{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.shell.atuin;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.modules.shell.atuin = {
    enable = lib.mkEnableOption "atuin";
    package = lib.mkPackageOption pkgs "atuin" { };
    flags = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
    settings = lib.mkOption {
      inherit (tomlFormat) type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      package = cfg.package;
      flags = cfg.flags;
      settings = cfg.settings;
    };
  };
}
