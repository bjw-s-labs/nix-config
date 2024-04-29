{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.bind;
in
{
  options.modules.services.bind = {
    enable = lib.mkEnableOption "bind";
    package = lib.mkPackageOption pkgs "bind" { };
    config = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.resolvconf.useLocalResolver = lib.mkForce false;

    # Clean up journal files
    systemd.services.bind = {
      preStart = lib.mkAfter ''
        rm -rf ${config.services.bind.directory}/*.jnl
      '';
    };

    services.bind = {
      enable = true;
      inherit (cfg) package;
      ipv4Only = true;
      configFile = pkgs.writeText "bind.cfg" cfg.config;
    };
  };
}
