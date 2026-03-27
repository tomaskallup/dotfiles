{ pkgs, lib, expert, llm-nix, ... }@args:
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

  home-manager.users.armeeh = ((import ./home.nix) args);
}
