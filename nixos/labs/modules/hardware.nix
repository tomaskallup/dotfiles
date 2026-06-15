{ pkgs, ... }:
{
  boot.plymouth.enable = true;
  # Add encrypted drive to initrd
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.initrd.availableKernelModules = [
    "thinkpad_acpi"
  ];
  boot.kernelParams = [
    "thinkpad_acpi.fan_control=1"
  ];

  boot.loader.grub.enable = true;

  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";

  # suspend-then-hibernate
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "1h";
    SuspendState = "mem";
  };
  services.logind.settings.Login.HandleLidSwitch = "ignore";

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
    };
  };

  services.fwupd.enable = false;
  services.thermald.enable = true;

  services.earlyoom.enable = true;

  hardware.acpilight.enable = true;

  # And bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  services.libinput = {
    enable = true;

    touchpad = {
      accelProfile = "adaptive";
      tapping = true;
      clickMethod = "clickfinger";
    };
  };
}
