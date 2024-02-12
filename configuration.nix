# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };

  # Use nix-prefetch-github tomaskallup dwl to get new sha
  dwl-custom-source = pkgs.fetchFromGitHub {
    owner = "tomaskallup";
    repo = "dwl";
    rev = "main";
    hash = "sha256-Uf/akqwkjTadgv9mNZobisKoYUBhV8p3B2koMvLsdKw=";
  };

  dwl-custom = (pkgs.callPackage "${dwl-custom-source}/dwl-custom.nix" {});
  unstable = import <unstable> { config = { allowUnfree = true; }; };

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-label/nix-encrypted-root";
      preLVM = true;
      allowDiscards = true;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_lqx;

  networking.hostName = "malus-nixus"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon = {
      settings = {
        data-root = "/data/docker";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.extraHosts =
  ''
    192.168.3.53 yomama.reaslocal
  '';

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #console = {
    #packages = with pkgs; [iosevka];
    #font = "${pkgs.iosevka}/share/fonts/truetype/iosevka-regular.ttf";
    #keyMap = lib.mkForce "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Greeter/DM
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c ${dwl-custom}/bin/start-dwl.sh";
      };
    };
  };
  # Sleep on lid close
  services.logind.lidSwitch = "suspend-then-hibernate";
  # Install packages
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
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
  services.mongodb = {
    enable = true;
    dbpath = "/data/mongodb";
    package = pkgs.mongodb-6_0;
    bind_ip = "127.0.0.1, 172.17.0.1, ::1";
  };
  services.postgresql = {
    enable = true;
    dataDir = "/data/postgres";
    package = pkgs.postgresql_14;
    enableTCPIP = false;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
    ensureDatabases = [ "distributor" ];
  };
  # Automatic disk mounting
  services.udisks2.enable = true;

  # Window server & related
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    # only needed for Sway
    XDG_CURRENT_DESKTOP = "sway"; 
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
    "firefox-test/policies/policies.json".text = ''
    {
      "policies": {
        "DontCheckDefaultBrowser": true,
        "DisableAppUpdate": true
      }
    }
    '';
  };


  programs.light.enable = true;
  programs.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.dconf.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config = {
      common = {
        default = "wlr";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    # Libraries
    zlib
    libinput
    libxkbcommon
    glib
    libnotify
    xorg.libxcb
    xorg.xcbutilwm
    libva
    wlroots
    shared-mime-info

    # Compilation tools
    gcc
    binutils
    glibc.static
    nix-prefetch-github

    # GUI Applications
    bemenu
    swaylock
    fnott
    wdisplays
    libsForQt5.kwalletmanager
    firefox-devedition-bin
    alacritty
    slack
    pavucontrol
    spotify
    gimp
    vlc
    winbox

    # CLI Tools
    wl-clipboard
    wl-clip-persist
    wlr-randr
    curl
    which
    inotify-tools
    xdg-utils # for opening default programs when clicking links
    swayidle
    cz-cli
    light
    diffutils
    diff-so-fancy
    fzy
    ripgrep
    grim
    slurp
    google-cloud-sdk
    mongodb-tools
    mongosh
    playerctl
    kanshi
    (ranger.overrideAttrs (r: {
      preConfigure = r.preConfigure + ''
        # Fix typescript files not being reported correctly
        substituteInPlace ranger/data/scope.sh \
          --replace 'text/* | */xml)' \
                    'text/* | */xml | JavaScript* | */javascript)'

        # Fix typescript files not being opened in editor
        substituteInPlace ranger/config/rifle.conf \
          --replace '!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php = ''${VISUAL:-$EDITOR} -- "$@"' \
                    '!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php|ts|tsx = ''${VISUAL:-$EDITOR} -- "$@"'
      '';
    }))
    kwalletcli # KDE wallet for 1password
    libsForQt5.kwallet
    tmux
    udisks
    nur.repos."999eagle".swayaudioidleinhibit # Make sure idle inhibitor is activated if audio is playing
    highlight

    # GUI Misc (themes, fonts, scripts etc)
    wayland
    dwl-custom
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors 
    dbus-sway-environment
    configure-gtk
    font-awesome
    flameshot
    unstable.satty
    waybar
    neovim
    greetd.tuigreet
    udiskie
  ]);
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
    noto-fonts-emoji
    symbola
    unifont
  ];
  
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "IosevkaTerm Nerd Font" ];
      emoji = [ "Noto Fonts Emoji" ];
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [hplipWithPlugin];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  # And bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.armeeh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" "network" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
  };
  home-manager.users.armeeh = 
    (import /home/armeeh/.config/home-manager/home.nix) pkgs;
  users.defaultUserShell = pkgs.zsh;

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
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Allow swaylock in PAM
  security.pam.services.swaylock = {};
  security.pam.services.greetd = {
    name = "kwallet";
    enableKwallet = true;
  };

  # Make PAM faster
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];


  security.sudo.extraRules = [
    { users = [ "armeeh" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  services.udev.extraRules = '''';
}
