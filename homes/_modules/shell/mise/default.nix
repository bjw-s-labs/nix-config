{
  pkgs,
  lib,
  config,
  flake-packages,
  ...
}:
let
  cfg = config.modules.shell.mise;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.modules.shell.mise = {
    enable = lib.mkEnableOption "mise";
    package = lib.mkPackageOption pkgs "mise" { };
    globalConfig = lib.mkOption {
      inherit (tomlFormat) type;
      default = { };
    };
    settings = lib.mkOption {
      inherit (tomlFormat) type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
      flake-packages.${pkgs.system}.usage
    ];

    xdg.configFile = {
      "mise/config.toml" = lib.mkIf (cfg.globalConfig != { }) {
        source = tomlFormat.generate "mise-config" cfg.globalConfig;
      };
      "mise/settings.toml" = {
        source = tomlFormat.generate "mise-settings" (
          {
            experimental = true;
            python_venv_auto_create = true;
          } //
          cfg.settings
        );
      };
    };

    programs = {
      bash.initExtra = ''
        eval "$(${lib.getExe cfg.package} activate bash)"
      '';

      fish.shellInit = lib.mkAfter ''
        ${lib.getExe cfg.package} hook-env | source
        ${lib.getExe cfg.package} activate fish | source
      '';
    };
  };
}
