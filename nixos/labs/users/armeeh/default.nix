{ pkgs, ... }:
{
  nix.settings.trusted-users = [ "armeeh" ];

  users.users.armeeh = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "network"
      "networkmanager"
      "docker"
      "tty"
      "lp"
      "plugdev"
      "gamemode"
      "libvirtd"
      "kvm"
    ];
  };
}
