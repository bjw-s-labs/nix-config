{ inputs, ... }: let
  inherit (inputs.nixpkgs) lib;

  recursiveMerge = attrList:
    let f = attrPath:
      lib.zipAttrsWith (n: values:
        if lib.tail values == []
          then lib.head values
        else if lib.all lib.isList values
          then lib.unique (lib.concatLists values)
        else if lib.all lib.isAttrs values
          then f (attrPath ++ [n]) values
        else lib.last values
      );
    in f [] attrList;

in {

  mkNixosSystem = system: hostname:
    lib.nixosSystem {
      inherit system;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../packages/overlay.nix {inherit inputs system;})
        ];
      };
      modules = [
        {
          _module.args = {
            inherit inputs system;
            myConfig = { hostname = hostname; };
            # nvfetcherPath = ../packages/_sources/generated.nix;
            myPkgs = inputs.self.legacyPackages.${system};
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
              overlays = [ (import ../packages/overlay.nix {inherit inputs system;}) ];
            };
            myLib = {
              recursiveMerge = recursiveMerge;
            };
          };
        }
        inputs.home-manager.nixosModules.home-manager
        # Load the modules
        ../modules/common
        ../modules/nixos
        # Host specific configuration
        ../hosts/${hostname}/configuration.nix
        # Host specific hardware configuration
        ../hosts/${hostname}/hardware-configuration.nix
      ];
    };

  mkDarwinSystem = system: hostname:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../packages/overlay.nix {inherit inputs system;})
        ];
      };
      modules = [
        {
          _module.args = {
            inherit inputs system;
            myConfig = { hostname = hostname; };
            myPkgs = inputs.self.legacyPackages.${system};
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
              overlays = [ (import ../packages/overlay.nix {inherit inputs system;}) ];
            };
            myLib = {
              recursiveMerge = recursiveMerge;
            };
          };
        }
        inputs.home-manager.darwinModules.home-manager
        # Load the modules
        ../modules/common
        ../modules/darwin
        # Host specific configuration
        ../hosts/${hostname}/configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
}
