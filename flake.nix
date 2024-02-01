{
  description = "bjw-s Nix Flake";

  nixConfig = {
    extra-trusted-substituters = [
      "https://bjw-s.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "bjw-s.cachix.org-1:dWyzjMYlnKeq01PplRWadakXfZQBoxJN7zGO6/HwsPs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-fast-build
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # deploy-rs
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  in
  {
    hosts = import ./hosts.nix;
    lib = import ./lib inputs;

    pkgs = forAllSystems (localSystem: import nixpkgs {
      inherit localSystem;
      overlays = [ self.overlays.default ];
      config = {
        allowUnfree = true;
        allowAliases = true;
      };
    });

    pkgs-unstable = forAllSystems (localSystem: import nixpkgs-unstable {
      inherit localSystem;
      overlays = [ self.overlays.default ];
      config = {
        allowUnfree = true;
        allowAliases = true;
      };
    });

    overlays = import ./lib/generateOverlays.nix inputs;
    packages = forAllSystems (import ./packages inputs);

    deploy = import ./deploy.nix inputs;
    nixosConfigurations = import ./lib/generateNixosConfigurations.nix inputs;
    darwinConfigurations = import ./lib/generateDarwinConfigurations.nix inputs;
  };
}
