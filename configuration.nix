# Boot into NixOS ISO
# mount /dev/your-root /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix   # paste this config & edit
# nixos-install

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,  ... }:

let
  userName     = "syevt"; # my user names are the same, both for the system and on the github, change appropriately
  dotfilesDir  = "/home/${userName}/.dotfiles";
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.${userName} = { config, pkgs, lib, ... }: {
    home.stateVersion = "25.05"; # match your NixOS version

    # Clone dotfiles repo on first activation
    home.activation.cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${dotfilesDir}" ]; then
        ${pkgs.git}/bin/git clone https://github.com/${userName}/dotfiles.git "${dotfilesDir}"
      fi
    '';

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files";
      defaultOptions = [ "--layout reverse" ];
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.tmux = {
      enable = true;

      baseIndex = 1;

      plugins = with pkgs.tmuxPlugins; [
        continuum
        resurrect
        vim-tmux-navigator
      ];

      extraConfig = ''
        # Environment variable pointing to continuum plugin
        set-environment -g TMUX_CONTINUUM_PATH ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum
        set-environment -g TMUX_RESURRECT_DIR "$HOME/.tmux/resurrect"

        set -g @resurrect-strategy-vim 'session'
        set -g @continuum-save-interval '5'
        set -g @continuum-restore 'on'

        source-file ${dotfilesDir}/.tmux.conf
        run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
      '';

    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      history = {
        saveNoDups = true;
        # these two are needed to access history inside `nix develop`
        append = true;
        share = true;
      };
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = [ "match_prev_cmd" ];
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "vi-mode" "yarn" ];
        custom = "${dotfilesDir}/zsh_custom";
      };

       initContent = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${dotfilesDir}/.zshrc
      '';
    };

    home.file.".alacritty.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.alacritty.toml";
    home.file.".bash_aliases".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.bash_aliases";
    home.file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/nvim";
    # home.file.".config/nvim/init.vim".source =
      # config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/nvim/init.vim";
    # home.file.".config/nvim/coc-settings.json".source =
      # config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/nvim/coc-settings.json";
    home.file.".config/fuzzel/fuzzel.ini".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/fuzzel/fuzzel.ini";
    home.file.".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.gitconfig";
    home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/hypr";
    home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/niri";

    home.file.".tmux/segments/".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux/segments/";
    home.file.".tmux/gruvbox-dark.sh".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux/gruvbox-dark.sh";
    home.file.".tmux/segment.sh".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux/segment.sh";
    home.file.".tmux/status.sh".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux/status.sh";
    home.file.".tmux/window.sh".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tmux/window.sh";

    home.file.".tridactylrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.tridactylrc";
    # home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.vimrc";
    # home.file.".vim/after/syntax/nerdtree.vim".source =
      # config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.vim/after/syntax/nerdtree.vim";
    home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/waybar";
    home.file.".config/wlogout".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/wlogout";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = pkgs.lib.mkAfter ["ecryptfs"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # services.systembus-notify.enable = true;

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = [ pkgs.vaapiVdpau pkgs.libvdpau-va-gl ];
  # };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.tor = {
    enable = true;
    client.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    isNormalUser = true;
    description = "syevt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # fonts
  fonts.packages = with pkgs; [
    font-awesome
    material-icons
    nerd-fonts.jetbrains-mono
    weather-icons
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # zsh
  programs.zsh.enable = true;
  # programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # users.defaultUserShell = pkgs.zsh;

  # that's the hack to make things like `nodenv` work
  programs.nix-ld.enable = true;

  programs.niri.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
   alacritty
   audacious
   bat
   bibata-cursors
   brightnessctl
   chromium
   delta
   ecryptfs
   jq
   kdePackages.falkon
   fd
   fuzzel
   fzf
   gimp
   git
   google-chrome
   kdePackages.gwenview
   hypridle
   hyprlock
   hyprpaper
   kdePackages.kpat
   libnotify
   light
   llvmPackages.clang
   lm_sensors
   neofetch
   neovim
   niri
   noto-fonts-color-emoji
   oh-my-zsh
   qbittorrent
   ripgrep
   signal-desktop
   slurp
   stow
   swaynotificationcenter
   xfce.thunar
   xfce.thunar-volman
   xfce.thunar-archive-plugin
   tmux
   tor
   tree
   ungoogled-chromium
   unzip
   usb-modeswitch
   usbutils
   viber
   vlc
   waybar
   wasistlos
   wl-clipboard
   wlogout
   wttrbar
   xclip
   xsensors
   zsh
   zsh-powerlevel10k
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
