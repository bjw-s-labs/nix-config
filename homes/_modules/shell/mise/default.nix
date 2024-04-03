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
  # TODO: Replace with official home manager module once available
  options.modules.shell.mise = {
    enable = lib.mkEnableOption "mise";
    package = lib.mkPackageOption pkgs "mise" { };
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
