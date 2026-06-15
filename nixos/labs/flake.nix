{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }:
    {
      # NOTE: 'nixos' is the default hostname
      nixosConfigurations.labs1 = nixpkgs.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          ./labs1-hardware-configuration.nix
          ./modules/nix.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          ./modules/hardware.nix
          ./modules/network.nix
          ./modules/virtualisation.nix
          ./modules/userspace.nix
          ./users/armeeh/default.nix
        ];
      };
    };
}
