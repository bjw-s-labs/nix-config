{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.smartctl-exporter;
in
{
  options.modules.services.smartctl-exporter = {
    enable = lib.mkEnableOption "smartctl-exporter";
    port = lib.mkOption {
      type = lib.types.int;
      default = 9633;
    };
  };

  config = lib.mkIf cfg.enable {
    services.prometheus.exporters.smartctl = {
      enable = true;
      inherit (cfg) port;
    };
  };
}
