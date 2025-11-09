# Boot into NixOS ISO
# mount /dev/your-root /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix   # paste this config & edit
# nixos-install
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  userName = "syevt"; # my user names are the same, both for the system and on the github, change appropriately
  dotfilesDir = "/home/${userName}/.dotfiles";
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.${userName} = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home = {
      stateVersion = "25.05"; # match your NixOS version

      # Clone dotfiles repo on first activation
      activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "${dotfilesDir}" ]; then
          ${pkgs.git}/bin/git clone https://github.com/${userName}/dotfiles.git "${dotfilesDir}"
        fi
      '';
      file = let
        link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
        files = [
          ".alacritty.toml"
          ".bash_aliases"
          ".config/nvim"
          ".config/fuzzel/fuzzel.ini"
          ".gitconfig"
          ".config/hypr"
          ".config/niri"
          ".tmux/segments/"
          ".tmux/gruvbox-dark.sh"
          ".tmux/segment.sh"
          ".tmux/status.sh"
          ".tmux/window.sh"
          ".tridactylrc"
          ".config/waybar"
          ".config/wlogout"
        ];
      in
        builtins.listToAttrs (map (path: {
            name = path;
            value.source = link path;
          })
          files);
    };

    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = "rg --files";
        defaultOptions = ["--layout reverse"];
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      tmux = {
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

      zsh = {
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
          strategy = ["match_prev_cmd"];
        };

        oh-my-zsh = {
          enable = true;
          plugins = ["git" "vi-mode" "yarn"];
          custom = "${dotfilesDir}/zsh_custom";
        };

        initContent = ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          source ${dotfilesDir}/.zshrc
        '';
      };
    };
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = pkgs.lib.mkAfter ["ecryptfs"];
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Enable networking
    networkmanager.enable = true;
    networkmanager.unmanaged = [];
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    nameservers = ["1.1.1.1" "8.8.8.8"];
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
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

  security.rtkit.enable = true;
  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services = {
    # services.systembus-notify.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "dvorak";
      };
      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;
    };

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
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

    tor = {
      enable = true;
      client.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userName} = {
    isNormalUser = true;
    description = "syevt";
    extraGroups = ["networkmanager" "wheel"];
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

  programs = {
    # Install firefox.
    firefox.enable = true;
    # zsh
    zsh.enable = true;
    # zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    # users.defaultUserShell = pkgs.zsh;
    # that's the hack to make things like `nodenv` work
    nix-ld.enable = true;
    niri.enable = true;
    nm-applet.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

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
    alacritty
    alejandra
    audacious
    bat
    bemoji
    bibata-cursors
    brightnessctl
    chromium
    crow-translate
    deadnix
    delta
    dig
    ecryptfs
    jq
    kdePackages.falkon
    fd
    fuzzel
    fzf
    gimp
    git
    google-chrome
    grim
    kdePackages.gwenview
    hypridle
    hyprlock
    hyprpaper
    kdePackages.kpat
    libnotify
    libreoffice
    light
    llvmPackages.clang
    lm_sensors
    lua54Packages.luacheck
    neofetch
    neovim
    networkmanagerapplet
    niri
    noto-fonts-color-emoji
    oh-my-zsh
    qbittorrent
    ripgrep
    signal-desktop
    slurp
    statix
    stow
    swaynotificationcenter
    tesseract
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
    vscode
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
