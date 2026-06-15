{ lib, ... }:
{
  networking.hostName = "labs1";

  networking.networkmanager = {
    enable = true;
    wifi = {
      powersave = false;
    };
  };

  networking.hosts = lib.mkForce {
    "127.0.0.1" = [
      "localhost"
      "labs1"
    ];
  };

  networking.firewall.enable = false;

  services.openssh = {
    enable = true;
  };
}
