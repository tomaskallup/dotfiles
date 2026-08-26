{ pkgs, ... }:
{
  # Enable virtmanager
  programs.virt-manager = {
    enable = true;
  };
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon = {
      settings = {
        data-root = "/data/docker";
        dns = [
          "8.8.8.8"
          "1.1.1.1"
        ];
      };
    };
  };
}
