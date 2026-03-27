{ lib, ... }: 
{

  networking.hostName = "malus-nixus";

  networking.networkmanager = {
    enable = true;
    wifi = {
      powersave = false;
    };
  };

  networking.hosts = lib.mkForce {
    "127.0.0.1" = [
      "localhost"
      "malus-nixus"
    ];
    "127.0.0.2" = [ ];
    "192.168.3.53" = [ "yomama.reaslocal" ];
    "192.168.3.60" = [ "rpi-proxy.reaslocal" ];
    # "192.168.3.173" = [ "malus-nixus" ];
  };

  networking.firewall.enable = false;
}
