{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.chrony;
in
{
  options.modules.services.chrony = {
    enable = lib.mkEnableOption "chrony";
    package = lib.mkPackageOption pkgs "chrony" { };
    servers = lib.mkOption {
      default = config.networking.timeServers;
      defaultText = lib.literalExpression "config.networking.timeServers";
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    services.chrony = {
      inherit (cfg) servers;
      enable = true;
      # enableNTS = true;
      package = cfg.package;
      extraConfig = ''
        allow all
        bindaddress 0.0.0.0
      '';
    };
  };
}
