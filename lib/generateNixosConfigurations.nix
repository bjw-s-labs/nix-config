{
  self,
  home-manager,
  nixpkgs,
  sops-nix,
  ...
}:
let
  inherit (nixpkgs) lib;
  genConfiguration = hostname: { address, hostPlatform, type, ... }:
    lib.nixosSystem {
      system = hostPlatform;

      modules = [
        {
          _module.args = {
            system = hostPlatform;
            myPackages = self.packages.${hostPlatform};
            pkgs-unstable = self.pkgs-unstable.${hostPlatform};
            myLib = self.lib;
          };
          nixpkgs.pkgs = self.pkgs.${hostPlatform};
        }

        home-manager.nixosModules.home-manager
        # Load the modules
        ../modules/common
        ../modules/nixos
        # Host specific configuration
        ../hosts/${hostname}/configuration.nix
        # Host specific hardware configuration
        ../hosts/${hostname}/hardware-configuration.nix
      ];
      specialArgs = {
        hostType = type;
        hostAddress = address;
        hostName = hostname;
        inherit
          home-manager
          sops-nix;
      };
    };
in
lib.mapAttrs
  genConfiguration
  (lib.filterAttrs (_: host: host.type == "nixos") self.hosts)
