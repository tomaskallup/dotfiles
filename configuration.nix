# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, lib, ... }:

let
  session = "dwm";
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
      dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Adwaita-dark'
    '';
  };

  unstable = import <unstable> { config = { allowUnfree = true; }; };

  # Use nix-prefetch-github tomaskallup dwl to get new sha
  dwl-custom-source = pkgs.fetchFromGitHub {
    owner = "tomaskallup";
    repo = "dwl";
    # rev = "main";
    # hash = "sha256-7qdNIt5AT8k0FSF0y+Pj2wakCTR3jUHpuGHvr0u29U4=";
    rev = "clean";
    hash = "sha256-MNAgTzjmBtdp5VYUb1+zQfrjax0qH1iwR07pdGYTJMI=";
  };

  dwm-custom = builtins.getFlake ("github:tomaskallup/dwm/clean");

  dmenu-custom = builtins.getFlake ("github:tomaskallup/dmenu/clean");

  dwl-custom = (unstable.callPackage "${dwl-custom-source}/dwl-custom.nix" {});

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    frozenMongo = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/fd04bea4cbf76f86f244b9e2549fca066db8ddff.tar.gz") {
      inherit pkgs;
      config.allowUnfree = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.cores = 8;

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
  # boot.kernelPackages = pkgs.linuxPackages_lqx;

  networking.hostName = "malus-nixus"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Enable waydroid
  virtualisation.waydroid.enable = true;
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
  # Run mongodb in docker as systemd service
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      mongodb = {
        image = "mongo:6.0.13";
        autoStart = true;
        ports = [ "27017:27017" ];
        user = "995:994";
        volumes = [ "/data/mongodb:/data/db" "/tmp:/tmp" ];
        extraOptions = [ "--ulimit=nofile=26677:46677" "--ulimit=nproc=65535" ];
      };
    };
  };
  systemd.services = {
    "lock-before-sleep@armeeh" = {
      unitConfig = {
        Description="Lock before sleep";
        Before="sleep.target";
      };

      path = with pkgs; [
        xorg.xrandr
        i3lock-fancy-rapid
        gawk
      ];

      serviceConfig = {
        User="%I";
        Type="forking";
        Environment = [
          "DISPLAY=:0"
        ];
        ExecStart=''
          ${dwm-custom.outputs.packages.${pkgs.system}.default}/bin/lock-xorg.sh
        '';
      };

      wantedBy = ["sleep.target"];
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
    enable = session == "dwl";
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
  programs.adb.enable = false;
  programs.winbox = {
    enable = true;
    openFirewall = true;
  };

  services.mongodb = {
    enable = false;
    dbpath = "/data/mongodb";
    package = pkgs.frozenMongo.mongodb-6_0;
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
    EDITOR = "nvim";
    GTK_THEME = "Adwaita-dark";
  } // (if session == "dwl" then {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway"; 
    NIXOS_OZONE_WL = "1";
  } else {
    VDPAU_DRIVER = "va_gl";
  });
  environment.etc = {
    "firefox-test/policies/policies.json".text = ''
    {
      "policies": {
        "DontCheckDefaultBrowser": true,
        "DisableAppUpdate": true
      }
    }
    '';
  } // ( if session == "dwl" then { "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
    } else {} );

  programs.light.enable = true;
  programs.xwayland.enable = session == "dwl";
  programs.waybar.enable = session == "dwl";
  programs.dconf = {
    enable = true;
  };
  services.dbus.enable = true;
  xdg.portal = lib.mkIf (session == "dwl") {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk ] ++ (if session == "dwl" then [ pkgs.xdg-desktop-portal-wlr ] else []);
    config = {
      common = {
        default = if session == "dwl" then "wlr" else "gtk";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable manpages for libs
  documentation.dev.enable = true;

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

    # GUI Applications
    libsForQt5.kwalletmanager
    firefox-devedition
    alacritty
    slack
    pavucontrol
    spotify
    gimp
    inkscape
    vlc
    libreoffice-qt
    ungoogled-chromium

    # CLI Tools
    curl
    which
    inotify-tools
    xdg-utils # for opening default programs when clicking links
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
    pciutils
    ranger
    kwalletcli # KDE wallet for 1password
    libsForQt5.kwallet
    tmux
    udisks
    highlight
    imagemagick_light
    file
    httpie
    lm_sensors

    # GUI Misc (themes, fonts, scripts etc)
    gnome.gnome-themes-extra # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors 
    gnome.adwaita-icon-theme  # default gnome cursors 
    font-awesome
    flameshot
    unstable.satty
    neovim
    udiskie
    configure-gtk
  ] ++ (if session == "dwl" then [
    bemenu
    dbus-sway-environment
    dwl-custom
    fnott
    greetd.tuigreet
    kanshi
    nur.repos."999eagle".swayaudioidleinhibit # Make sure idle inhibitor is activated if audio is playing
    swayidle
    swaylock
    wayland
    wdisplays
    wineWowPackages.waylandFull
    wl-clip-persist
    wl-clipboard
    wl-clipboard-x11
    wlr-randr
    wlroots
  ] else [
    dwm-custom.outputs.packages.${system}.default
    dmenu-custom.outputs.packages.${system}.default
    i3lock-fancy-rapid
    xclip
    xidlehook
    xorg.xinit
    wineWowPackages.full
  ]));
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "NerdFontsSymbolsOnly" ]; })
    iosevka
    noto-fonts-emoji
    symbola
    unifont
  ];
  
  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
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
    nssmdns4 = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = session == "dwm";
    package = pkgs.pulseaudioFull;
    /* configFile = pkgs.writeText "default.pa" ''
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
      ## module fails to load with 
      ##   module-bluez5-device.c: Failed to get device path from module arguments
      ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
      # load-module module-bluez5-device
      # load-module module-bluez5-discover
    ''; */

  };
  services.pipewire = {
    enable = session == "dwl";
    alsa.enable = session == "dwl";
    pulse.enable = session == "dwl";
  };
  # And bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  services.libinput = {
    enable = session == "dwm";

    # disabling touchpad acceleration
    touchpad = {
      accelProfile = "adaptive";
      tapping = true;
      clickMethod = "clickfinger";
    };
  };

  services.xserver = {
    enable = session == "dwm";
    videoDrivers = ["modesetting"];
    /* deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
    ''; */
    excludePackages = with pkgs; [
      xterm
    ];
    xkb.options = "compose:ralt";
    displayManager.startx.enable = true;
  };
  services.autorandr = {
    enable = session == "dwm";
    profiles = {
      laptop-only = {
        config = {
          eDP1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
          };
          DP1 = {
            enable = false;
          };
          VIRTUAL1 = {
            enable = false;
          };
        };
        fingerprint = {
          eDP1="00ffffffffffff004d10ba1400000000161d0104a52213780ede50a3544c99260f505400000001010101010101010101010101010101ac3780a070383e403020350058c210000018000000000000000000000000000000000000000000fe004d57503154804c513135364d31000000000002410332001200000a010a202000d3";
        };
      };
      work = {
        config = {
          eDP1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            crtc = 0;
            position = "0x0";
            rate = "60";
          };
          DP1 = {
            enable = true;
            primary = false;
            mode = "2560x1440";
            crtc = 1;
            position = "1920x0";
            rate = "60";
          };
          DP2 = {
            enable = false;
          };
          DP3 = {
            enable = false;
          };
        };
        fingerprint = {
          DP1="00ffffffffffff00410c8fc1a10f00001d1d0103803c22782a67a1a5554da2270e5054bfef00d1c0b30095008180814081c0010101014dd000a0f0703e803020350055502100001aa36600a0f0701f803020350055502100001a000000fc0050484c203237364538560a2020000000fd0017501ea03c000a2020202020200171020333f14c9004031f1301125d5e5f606123090707830100006d030c001000387820006001020367d85dc401788003e30f000c565e00a0a0a029503020350055502100001e023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e4d6c80a070703e8030203a0055502100001a000000004e";
          eDP1="00ffffffffffff004d10ba1400000000161d0104a52213780ede50a3544c99260f505400000001010101010101010101010101010101ac3780a070383e403020350058c210000018000000000000000000000000000000000000000000fe004d57503154804c513135364d31000000000002410332001200000a010a202000d3";
        };
      };
      home = {
        config = {
          eDP1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            crtc = 0;
            position = "0x0";
            rate = "60";
          };
          DP3 = {
            enable = true;
            primary = false;
            mode = "2560x1440";
            scale = {
              method = "pixel";
              x = 1920;
              y = 1080;
            };
            crtc = 1;
            position = "1920x0";
            rate = "60";
          };
          DP1 = {
            enable = false;
          };
          DP2 = {
            enable = false;
          };
        };
        fingerprint = {
          DP3="00ffffffffffff0005e37928d0040000181d0103803e22782a08a5a2574fa2280f5054bfef00d1c0b30095008180814081c0010101014dd000a0f0703e80302035006d552100001aa36600a0f0701f80302035006d552100001a000000fc00553238373947360a2020202020000000fd0017501e8c3c000a2020202020200100020333f14c9004031f1301125d5e5f606123090707830100006d030c001000397820006001020367d85dc401788003e30f000c011d007251d01e206e2855006d552100001e8c0ad08a20e02d10103e96006d55210000184d6c80a070703e8030203a006d552100001aa36600a0f0701f80302035006d552100001a00000000ea";
          eDP1="00ffffffffffff004d10ba1400000000161d0104a52213780ede50a3544c99260f505400000001010101010101010101010101010101ac3780a070383e403020350058c210000018000000000000000000000000000000000000000000fe004d57503154804c513135364d31000000000002410332001200000a010a202000d3";
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.armeeh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" "network" "networkmanager" "docker" "adbusers" "tty" "lp" ];
  };
  users.groups.mongodb = {
    gid = 994;
  };
  users.users.mongodb = {
    isSystemUser = true;
    uid = 995;
    group = "mongodb";
    home = "/data/mongodb";
  };
  home-manager.users.armeeh = 
    (import /home/armeeh/.config/home-manager/home.nix) pkgs session;
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

  security.pki.certificates = [
    ''
Brightdata/Luminati
-----BEGIN CERTIFICATE-----
MIIFozCCA4ugAwIBAgIJAPnnIqmvvTArMA0GCSqGSIb3DQEBBQUAMD8xCzAJBgNV
BAYTAklMMQswCQYDVQQIEwJJTDENMAsGA1UEChMESG9sYTEUMBIGA1UEAxMLbHVt
aW5hdGkuaW8wHhcNMTYwOTI3MTQyODM4WhcNMjYwOTI1MTQyODM4WjA/MQswCQYD
VQQGEwJJTDELMAkGA1UECBMCSUwxDTALBgNVBAoTBEhvbGExFDASBgNVBAMTC2x1
bWluYXRpLmlvMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtiqw0DuX
g5g7BC+Cr7mZvgXB7CsJ10YFb2xwoDZlHHJ8G0KEMUeNiY9EjPR8ZIHlnjGJehsW
PUvJeSAoDnT+fh4udWyUJ3VSqDTyGpu4DpfLBwaaZP/fq45UeR0oLs3ZJd6joDss
AjJdQbdBPJj/57MjwbF+jddP6qm9XbCWjYzl1uxdMVjloetyRUgkhkh2ALp/VtK8
hUj/XgvD/Y1souKYs5DKayJTn+GM6MlSOUBQ0+b8yUbDb/9vjbHlX4pZ8gbgSEFf
xUV49Sxd6EhRXzFw4TERQVut0cgojmRmrgXXwc4kJi0Uvtc6tV/hJeH2yRS84Ehg
feY5dcJVc69ILYfGrNmwbFvf5aHZPWFG0kIcy9iMMk+3wSUaBP+FAYyd0i+PJTxy
5Jfmhs6BHowuEr0zgL+xge+/RCEbVUPvA6w9DWYbpqckZUh9sPga3JcHjaHGs6Cz
dnjEShgmlBm0DL6JMumLWFJrjztsm56Huuai0F5pwyrsyq8fbK6Sp18sq5/vH3Vy
t2XAj4EIFvpWHZjuocCe5/5vAbkSXjQ5HEIS+SyVhlFriCy5Mf3fTyMFqwm3tbZv
jEooumi0/9F2WvisUgheC1uatZ8M+Pzi+Kp3x2SSS992KWs0M35GEstiB09RkNHe
GItI6qxqY/Npw5u6lBE6Z28ISwvuet1a4vMCAwEAAaOBoTCBnjAdBgNVHQ4EFgQU
Wq7PsMnq2tuDhTV0oUW4jjzvLTcwbwYDVR0jBGgwZoAUWq7PsMnq2tuDhTV0oUW4
jjzvLTehQ6RBMD8xCzAJBgNVBAYTAklMMQswCQYDVQQIEwJJTDENMAsGA1UEChME
SG9sYTEUMBIGA1UEAxMLbHVtaW5hdGkuaW+CCQD55yKpr70wKzAMBgNVHRMEBTAD
AQH/MA0GCSqGSIb3DQEBBQUAA4ICAQA3oT4lrUErSqXjQtDUINo62KcJWs4kjEd8
qXZdl/HVim06nOG6DFZCSh8JngFi4MFmSzGlBGxe1pXaYArtekfLWmhwoVoJiiaA
DAAPItcZNlA9zIORyLZlrXlIuP5xzsb9PbnNWhd9xJHksHGoHDPHAW/KI/GJdjQv
uuCyObvv1IgGvfHbv4lXGCwQuU0OBGXv1kfZtAqUS+ei5zkK+nY0qc3L3Ce+Ow6h
/haDe0FDoT7zkwnEHu/ExCGSR3lNnyBAewlPVMzbJznuPMU3FFA3MHT7IcHxJWff
r8jOXo3qXWqd+T2oDO02KUR2ZVolI8FGx6yIKfLwWnj+eR2dfdMx0tUX4F6mRi4N
zGmhhIIHtViAMf59tBL7az26C8DGfX0p4oECpKtc86u5bYTbRZ1xrf6t/wFqqgB/
RVqn9IhSfXNZtxBn8G0odR8sPIiBxJKvkLMDKoAEeErwd0yqnr8FplskFuPn0FY5
N7n7dj5cHoSUtSAkM6bHCFY+XVtUoy6xisTAobajHvU3e2cDVKizC/ocUbHbTJgh
nevnzyTtKL2w820PDmI7plFN3wR3epd4kTAP5KT196Pjwjg+Dqgt2OnGAafKr+Qr
o2cdIF5MbULVkux4RKzpNKaoDtrnvC1jROM5s1R0Lb96dQcS/VwmyX22lKdbbY9F
ij5GZar9JA==
-----END CERTIFICATE-----
    ''
  ];

  services.udev.extraRules = '''';
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];
}
