{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm-custom.url = "github:tomaskallup/dwm/clean";
    dmenu-custom.url = "github:tomaskallup/dmenu/clean";
    conc.url = "github:prixladi/conc/master";
    expert.url = "github:elixir-lang/expert";
    llm-nix.url = "github:numtide/llm-agents.nix";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      ...
    }:
    {
      # NOTE: 'nixos' is the default hostname
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./modules/nix.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
          ./modules/hardware.nix
          ./modules/network.nix
          ./modules/virtualisation.nix
          ./modules/userspace.nix
          ./users/armeeh/default.nix
        ];
      };
    };
}
