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

  home-manager.users.${userName} = { pkgs, lib, ... }: {
    home.stateVersion = "25.05"; # match your NixOS version

    # Clone dotfiles repo on first activation
    home.activation.cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${dotfilesDir}" ]; then
        ${pkgs.git}/bin/git clone https://github.com/${userName}/dotfiles.git "${dotfilesDir}"
      fi
    '';

    # programs.zsh.enable = true;
    home.file.".alacritty.toml".source = "${dotfilesDir}/.alacritty.toml";
    home.file.".bash_aliases".source = "${dotfilesDir}/.bash_aliases";
    home.file.".gitconfig".source = "${dotfilesDir}/.gitconfig";
    home.file.".tridactylrc".source = "${dotfilesDir}/.tridactylrc";
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
  };

  # Install firefox.
  programs.firefox.enable = true;

  # zsh
  # programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;
  # users.users.syevt.shell = pkgs.shell;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
   light
   neofetch
   neovim
   niri
   nodejs_24
   noto-fonts-color-emoji
   oh-my-zsh
   zsh-powerlevel10k
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
   ungoogled-chromium
   vlc
   waybar
   whatsie
   wl-clipboard
   wlogout
   zsh
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
