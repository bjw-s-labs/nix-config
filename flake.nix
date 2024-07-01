{
  description = "bjw-s Nix Flake";

  inputs = {
    # Nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode community extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchain overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix/v1.0.1";
    };

    nix-inspect.url = "github:bluskript/nix-inspect";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    nix-inspect,
    nixvim,
    nix-vscode-extensions,
    sops-nix,
    rust-overlay,
    ...
  } @inputs:
  let
    supportedSystems = ["x86_64-linux" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    overlays = import ./overlays {inherit inputs;};
    mkSystemLib = import ./lib/mkSystem.nix {inherit inputs overlays;};
    flake-packages = self.packages;

    legacyPackages = forAllSystems (
      system:
        import nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
    );
  in
  {
    inherit overlays;

    packages = forAllSystems (
      system: let
        pkgs = legacyPackages.${system};
      in
        import ./pkgs {
          inherit pkgs;
          inherit inputs;
        }
    );

    nixosConfigurations = {
      gladius = mkSystemLib.mkNixosSystem "x86_64-linux" "gladius" flake-packages;
      milton = mkSystemLib.mkNixosSystem "x86_64-linux" "milton" flake-packages;
    };

    darwinConfigurations = {
      bernd-macbook = mkSystemLib.mkDarwinSystem "aarch64-darwin" "bernd-macbook" flake-packages;
      infraworkz = mkSystemLib.mkDarwinSystem "aarch64-darwin" "infraworkz" flake-packages;
    };

    # Convenience output that aggregates the outputs for home, nixos.
    # Also used in ci to build targets generally.
    ciSystems =
      let
        nixos = nixpkgs.lib.genAttrs
          (builtins.attrNames inputs.self.nixosConfigurations)
          (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);
        darwin = nixpkgs.lib.genAttrs
          (builtins.attrNames inputs.self.darwinConfigurations)
          (attr: inputs.self.darwinConfigurations.${attr}.system);
      in
        nixos // darwin;
  };
}
