# Boot into NixOS ISO
# mount /dev/your-root /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix   # paste this config & edit
# nixos-install
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  # config,
  pkgs,
  ...
}: let
  userName = "syevt"; # my user names are the same, both for the system and on github, change appropriately
  dotfilesDir = "/home/${userName}/.dotfiles";
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
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
      stateVersion = "25.05"; # should match your NixOS system.stateVersion

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
          ".config/fuzzel/fuzzel.ini"
          ".config/ghostty/config.ghostty"
          ".config/inputactions/config.yaml"
          ".config/kitty/kitty.conf"
          ".config/niri"
          ".config/noctalia"
          ".config/nvim"
          ".gitconfig"
          ".tmux/gruvbox-dark.sh"
          ".tmux/segments/"
          ".tmux/segment.sh"
          ".tmux/status.sh"
          ".tmux/window.sh"
          ".tridactylrc"
          ".stylua.toml"
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
      mpv = {
        enable = true;

        scripts = with pkgs.mpvScripts; [
          uosc
        ];
      };
    };

    systemd.user.services.inputactions-client = {
      Unit = {
        Description = "InputActions client";
        After = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${config.home.homeDirectory}/.local/bin/inputactions-client";
        Restart = "always";
        RestartSec = 3;
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.unmanaged = [];
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = false;
          ControllerMode = "dual";
        };
      };
    };
    graphics.enable = true;
  };

  time.timeZone = "Europe/Kyiv";

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
  console.keyMap = "dvorak";

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      xkb = {
        layout = "us";
        variant = "dvorak";
      };
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
    };

    tor = {
      enable = true;
      client.enable = true;
    };

    tuned.enable = true;
    upower.enable = true;
  };

  users.users.${userName} = {
    isNormalUser = true;
    description = "syevt";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    font-awesome
    material-icons
    nerd-fonts.jetbrains-mono
    weather-icons
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
    # that's the hack to make things like `nodenv` work
    nix-ld.enable = true;
    niri.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  systemd = {
    services = {
      battery-charge-limit = {
        description = "Set battery charge limit";
        wantedBy = ["multi-user.target"];
        serviceConfig.Type = "oneshot";
        script = ''
          echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold
        '';
      };
      inputactionsd = {
        description = "InputActions daemon";
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          ExecStart = "/home/syevt/.local/bin/inputactionsd";
          Restart = "always";
          RestartSec = 3;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    anki
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
    elastic
    kdePackages.falkon
    fd
    fuzzel
    fzf
    ghostty
    gimp
    git
    gocryptfs
    google-chrome
    gparted
    grim
    kdePackages.gwenview
    jq
    kdePackages.kpat
    kitty
    libnotify
    libreoffice
    llvmPackages.clang
    lm_sensors
    lua54Packages.luacheck
    mpvpaper
    neovim
    niri
    noctalia
    noto-fonts-color-emoji
    oh-my-zsh
    pcmanfm
    postman
    qbittorrent
    recoll
    ripgrep
    ripgrep-all
    satty
    signal-desktop
    sioyek
    slurp
    smplayer
    statix
    stow
    tesseract
    tmux
    tor
    translate-shell
    tree
    tree-sitter
    unzip
    usb-modeswitch
    usbutils
    viber
    vlc
    vscode
    wl-clipboard
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
