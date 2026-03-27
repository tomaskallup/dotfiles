{ pkgs, ... }:
{
  # Ensure systemd loads in initrd, this helps with hibernation & swap files
  boot.initrd.systemd.enable = true;
  # Add encrypted drive to initrd
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-label/nixos-encrypted-root";
      preLVM = true;
      allowDiscards = true;
    };
  };
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";

  # suspend-then-hibernate
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "1h";
    SuspendState = "mem";
  };
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";

  services.thinkfan.enable = false;
  services.thinkfan.levels = [
    [
      0
      0
      50
    ]
    [
      1
      48
      60
    ]
    [
      2
      50
      61
    ]
    [
      3
      54
      63
    ]
    [
      6
      56
      65
    ]
    [
      7
      60
      85
    ]
    [
      "level auto"
      80
      32767
    ]
  ];
  programs.coolercontrol.enable = true;

  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "Hibernate";
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  services.fwupd.enable = false;
  services.thermald.enable = true;

  services.earlyoom.enable = true;

  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
    extraPackages = with pkgs; [
      # vaapiIntel
      libvdpau-va-gl
      # intel-media-driver
    ];
    extraPackages32 = with pkgs; [
      # vaapiIntel
      libvdpau-va-gl
      # intel-media-driver
    ];
  };

  services.udev.extraRules = "";
  services.udev.packages = with pkgs; [ qmk-udev-rules ];

  services.pipewire.enable = false;
  services.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;

  };

  hardware.acpilight.enable = true;

  # And bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  services.deluge = {
    enable = true;
    web.enable = true;
  };

  # Enable CUPS for printing.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplipWithPlugin ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.libinput = {
    enable = true;

    touchpad = {
      accelProfile = "adaptive";
      tapping = true;
      clickMethod = "clickfinger";
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    # videoDrivers = ["intel"];
    deviceSection = ''
      Option "TearFree" "true"
    '';
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
    extraConfig = ''
      Section "Extensions"
        Option "DPMS" "false"
      EndSection
    '';
    excludePackages = with pkgs; [ xterm ];
    xkb.options = "compose:ralt";
    displayManager.startx.enable = true;
  };

  services.autorandr = {
    enable = true;
    profiles = {
      lenovo-laptop-only = {
        config = {
          eDP = {
            enable = true;
            primary = true;
            mode = "1920x1200";
          };
          DisplayPort-1 = {
            enable = false;
          };
          DisplayPort-2 = {
            enable = false;
          };
          DisplayPort-3 = {
            enable = false;
          };
          VIRTUAL1 = {
            enable = false;
          };
        };
        fingerprint = {
          eDP = "00ffffffffffff0030ae3d4000000000001f0104a51e1378e3aeac93585991281d505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00283c4b4b10010a2020202020200000000f00d10a3cd10a281e0a0006af9bfa000000fe004231343055414e30332e32200a00ba";
        };
      };
      lenovo-work = {
        config = {
          eDP = {
            enable = true;
            primary = true;
            mode = "1920x1200";
          };
          DisplayPort-0 = {
            enable = true;
            mode = "2560x1440";
            crtc = 1;
            position = "1920x0";
            rate = "32.08";
          };
          DisplayPort-1 = {
            enable = false;
          };
          DisplayPort-2 = {
            enable = false;
          };
          DisplayPort-3 = {
            enable = false;
          };
          VIRTUAL1 = {
            enable = false;
          };
        };
        fingerprint = {
          eDP = "00ffffffffffff0030ae3d4000000000001f0104a51e1378e3aeac93585991281d505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00283c4b4b10010a2020202020200000000f00d10a3cd10a281e0a0006af9bfa000000fe004231343055414e30332e32200a00ba";
          DisplayPort-0 = "00ffffffffffff00410c8fc1a10f00001d1d0103803c22782a67a1a5554da2270e5054bfef00d1c0b30095008180814081c0010101014dd000a0f0703e803020350055502100001aa36600a0f0701f803020350055502100001a000000fc0050484c203237364538560a2020000000fd0017501ea03c000a2020202020200171020333f14c9004031f1301125d5e5f606123090707830100006d030c001000387820006001020367d85dc401788003e30f000c565e00a0a0a029503020350055502100001e023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e4d6c80a070703e8030203a0055502100001a000000004e";
        };
      };
      lenovo-work-no-dock = {
        config = {
          eDP = {
            enable = true;
            primary = true;
            mode = "1920x1200";
          };
          DisplayPort-2 = {
            enable = true;
            mode = "2560x1440";
            crtc = 1;
            position = "1920x0";
          };
          DisplayPort-1 = {
            enable = false;
          };
          DisplayPort-3 = {
            enable = false;
          };
          VIRTUAL1 = {
            enable = false;
          };
        };
        fingerprint = {
          eDP = "00ffffffffffff0030ae3d4000000000001f0104a51e1378e3aeac93585991281d505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00283c4b4b10010a2020202020200000000f00d10a3cd10a281e0a0006af9bfa000000fe004231343055414e30332e32200a00ba";
          DisplayPort-2 = "00ffffffffffff00410c8fc1a10f00001d1d0103803c22782a67a1a5554da2270e5054bfef00d1c0b30095008180814081c0010101014dd000a0f0703e803020350055502100001aa36600a0f0701f803020350055502100001a000000fc0050484c203237364538560a2020000000fd0017501ea03c000a2020202020200171020333f14c9004031f1301125d5e5f606123090707830100006d030c001000387820006001020367d85dc401788003e30f000c565e00a0a0a029503020350055502100001e023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e4d6c80a070703e8030203a0055502100001a000000004e";
        };
      };
      lenovo-home = {
        hooks = {
          preswitch = {
            "00-newMode" =
              "xrandr --newmode \"2560x1440_60.00\"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync && xrandr --addmode DP-3 2560x1440_60.00";
            "01-addMode" = "xrandr --addmode HDMI-A-0 \"2560x1440_60.00\"";
          };
        };

        config = {
          eDP = {
            enable = true;
            primary = true;
            mode = "1920x1200";
          };
          HDMI-A-0 = {
            enable = true;
            mode = "2560x1440_60.00";
            crtc = 1;
            position = "1920x0";
            rate = "32.08";
          };
          DisplayPort-1 = {
            enable = false;
          };
          DisplayPort-2 = {
            enable = false;
          };
          DisplayPort-3 = {
            enable = false;
          };
          VIRTUAL1 = {
            enable = false;
          };
        };
        fingerprint = {
          eDP = "00ffffffffffff0030ae3d4000000000001f0104a51e1378e3aeac93585991281d505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00283c4b4b10010a2020202020200000000f00d10a3cd10a281e0a0006af9bfa000000fe004231343055414e30332e32200a00ba";
          HDMI-A-0 = "00ffffffffffff0005e37928d0040000181d0103803e22782a08a5a2574fa2280f5054bfef00d1c0b30095008180814081c0010101014dd000a0f0703e80302035006d552100001aa36600a0f0701f80302035006d552100001a000000fc00553238373947360a2020202020000000fd0017501e8c3c000a2020202020200100020333f14c9004031f1301125d5e5f606123090707830100006d030c001000397820006001020367d85dc401788003e30f000c011d007251d01e206e2855006d552100001e8c0ad08a20e02d10103e96006d55210000184d6c80a070703e8030203a006d552100001aa36600a0f0701f80302035006d552100001a00000000ea";
        };
      };
    };
  };
}
