{
  pkgs,
  conc,
  dwm-custom,
  dmenu-custom,
  c3c,
  ...
}:
let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Adwaita-dark'
      '';
  };
in
{
  # Window server & related
  environment.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Adwaita-dark";
    MOZ_USE_XINPUT2 = "1";
    VDPAU_DRIVER = "va_gl";
  };

  security.pam.services.i3lock = {
    enable = true;
  };
  security.pam.services.i3lock-color = {
    enable = true;
  };
  security.pam.services.i3lock-fancy-rapid = {
    enable = true;
  };
  security.pam.services.startx = {
    name = "kwallet";
    enableKwallet = true;
  };

  # Make PAM faster
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  security.sudo.extraRules = [
    {
      users = [ "armeeh" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  users.groups.mongodb = {
    gid = 994;
  };
  users.users.mongodb = {
    isSystemUser = true;
    uid = 995;
    group = "mongodb";
    home = "/data/mongodb";
  };
  # Run mongodb in docker as systemd service
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      mongodb = {
        image = "mongo:6.0.13";
        autoStart = true;
        ports = [ "27017:27017" ];
        user = "995:994";
        volumes = [
          "/data/mongodb:/data/db"
          "/tmp:/tmp"
        ];
        extraOptions = [
          "--ulimit=nofile=26677:46677"
          "--ulimit=nproc=65535"
          "--memory=6G"
        ];
      };
    };
  };

  services.postgresql = {
    enable = true;
    dataDir = "/data/postgres";
    package = pkgs.postgresql_18;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all               trust
      host  all all 127.0.0.1/32  trust
      host  all all ::1/128       trust
      host  all all 172.0.0.0/8 trust
    '';
    ensureDatabases = [ "distributor" ];
    extensions = ps: with ps; [ postgis ];
  };

  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "Hibernate";
  };

  programs.dconf = {
    enable = true;
  };
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "armeeh" ];
  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };
  programs.git.enable = true;
  programs.htop.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  programs.winbox = {
    enable = true;
    openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          libkrb5
          keyutils
          gamemode
        ];
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
    noto-fonts-color-emoji
    symbola
    unifont
  ];

  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    defaultFonts = {
      monospace = [
        "ComicShannsMono Nerd Font"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
  };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = (
    with pkgs;
    [
      # Libraries
      zlib
      libinput
      libxkbcommon
      glib
      libnotify
      libxcb
      libxcb-wm
      libva
      hunspell
      hunspellDicts.cs_CZ
      hunspellDicts.en_US
      shared-mime-info
      lsof
      man-pages
      man-pages-posix

      # Compilation tools
      gcc
      binutils
      glibc.static
      nix-prefetch-github
      gnumake
      cmake
      c3c.outputs.packages.${stdenv.hostPlatform.system}.c3c

      # GUI Applications
      kdePackages.kwalletmanager
      firefox-devedition
      alacritty
      slack
      pavucontrol
      spotify
      gimp
      inkscape
      vlc
      mpv
      libreoffice-qt
      ungoogled-chromium
      sxiv
      prismlauncher
      pixelorama

      # CLI Tools
      curl
      which
      inotify-tools
      xdg-utils # for opening default programs when clicking links
      cz-cli
      brightnessctl
      diffutils
      diff-so-fancy
      difftastic
      fzy
      ripgrep
      grim
      slurp
      google-cloud-sdk
      mongodb-tools
      mongosh
      playerctl
      pciutils
      ranger
      kdePackages.kwallet-pam
      kdePackages.kwallet
      udisks
      highlight
      imagemagick_light
      file
      httpie
      lm_sensors
      tree
      tree-sitter
      neovim
      valgrind
      conc.outputs.packages.${stdenv.hostPlatform.system}.cli
      ncdu
      gh

      # GUI Misc (themes, fonts, scripts etc)
      gnome-themes-extra # gtk theme
      adwaita-icon-theme # default gnome cursors
      font-awesome
      flameshot
      satty
      udiskie
      configure-gtk

      dwm-custom.outputs.packages.${stdenv.hostPlatform.system}.default
      dmenu-custom.outputs.packages.${stdenv.hostPlatform.system}.default
      i3lock-fancy-rapid
      xclip
      xidlehook
      xinit
      upower
      dunst
      xdotool
    ]
  );

  systemd.services = {
    "lock-before-sleep@armeeh" = {
      unitConfig = {
        Description = "Lock before sleep";
        Before = "sleep.target";
      };

      path = with pkgs; [
        xrandr
        i3lock-fancy-rapid
        gawk
      ];

      serviceConfig = {
        User = "%I";
        Type = "forking";
        Environment = [ "DISPLAY=:0" ];
        ExecStart = ''
          ${dwm-custom.outputs.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/lock-xorg.sh
        '';
      };

      wantedBy = [ "sleep.target" ];
    };
  };
  systemd.user.services = {
    concd = conc.outputs.services.${pkgs.stdenv.hostPlatform.system}.daemon;
  };
}
