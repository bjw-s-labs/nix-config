{
  inputs,
  mkPkgsWithSystem,
  ...
}:
{
  mkNixosSystem = system: hostname:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = mkPkgsWithSystem system;
      modules = [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs system;
          };
        }
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
              inputs.catppuccin.homeManagerModules.catppuccin
            ];
            extraSpecialArgs = {
              inherit inputs hostname system;
            };
            users.bjw-s = ../. + "/homes/bjw-s";
          };
        }
        ../hosts/_modules/common
        ../hosts/_modules/nixos
        ../hosts/${hostname}
      ];
      specialArgs = {
        inherit inputs hostname;
      };
    };

  mkDarwinSystem = system: hostname:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      pkgs = mkPkgsWithSystem system;
      modules = [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs;
          };
        }
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
              inputs.catppuccin.homeManagerModules.catppuccin
            ];
            extraSpecialArgs = {
              inherit inputs hostname system;
            };
            users.bjw-s = ../. + "/homes/bjw-s";
          };
        }
        ../hosts/_modules/common
        ../hosts/_modules/darwin
        ../hosts/${hostname}
      ];
      specialArgs = {
        inherit inputs hostname;
      };
    };
}
