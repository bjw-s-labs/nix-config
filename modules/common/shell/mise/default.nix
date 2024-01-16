{ username }: {pkgs, lib, config, ... }:
with lib;

let
  cfg = config.modules.users.${username}.shell.mise;
  tomlFormat = pkgs.formats.toml { };

in {
  options.modules.users.${username}.shell.mise = {
    enable = mkEnableOption "${username} mise";

    # TODO: This will probably not work until nixpkgs adds the mise package
    package = mkPackageOption pkgs "mise" { };

    enableFishIntegration = mkEnableOption "Fish Integration" // {
      default = true;
    };

    config = mkOption {
      type = tomlFormat.type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [ cfg.package ];

      xdg.configFile."mise/settings.toml" = mkIf (cfg.config != { }) {
        source = tomlFormat.generate "mise-config" cfg.config;
      };

      programs = {
        fish.shellInit = mkIf cfg.enableFishIntegration (
          mkAfter ''
            ${getExe cfg.package} hook-env | source
            ${getExe cfg.package} activate fish | source
          ''
        );
      };
    };
  };
}
