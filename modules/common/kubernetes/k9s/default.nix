{ username }: args@{pkgs, lib, myLib, config, ... }:
with lib;

let
  cfg = config.modules.users.${username}.kubernetes.k9s;
  defaultConfig = (import ./defaultConfig.nix args);
  mergedConfig = (pkgs.formats.yaml { }).generate "k9s-config" (myLib.recursiveMerge [
    defaultConfig
    cfg.config
  ]);
  defaultAliases = (import ./defaultAliases.nix args);
  mergedAliases = (pkgs.formats.yaml { }).generate "k9s-aliases" {
    aliases = (myLib.recursiveMerge [
      defaultAliases
      cfg.aliases
    ]);
  };
in {
  options.modules.users.${username}.kubernetes.k9s = {
    enable = mkEnableOption "${username} k9s";
    package = mkPackageOption pkgs "k9s" { };
    aliases = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    config = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
  config = mkIf cfg.enable  (mkMerge [
    {
      home-manager.users.${username} = {
        home.packages = [
          cfg.package
        ];
      };
    }

    (mkIf (pkgs.stdenv.isDarwin) (
      {
        home-manager.users.${username} = {
          home.file."Library/Application Support/k9s/config.yaml" = {
            source = mergedConfig;
          };
          home.file."Library/Application Support/k9s/aliases.yaml" = {
            source = mergedAliases;
          };
        };
      }
    ))

    (mkIf (pkgs.stdenv.isLinux) (
      {
        home-manager.users.${username} = {
          xdg.configFile."k9s/config.yaml" = {
            source = mergedConfig;
          };
          xdg.configFile."k9s/aliases.yaml" = {
            source = mergedAliases;
          };
        };
      }
    ))
  ]);
}
