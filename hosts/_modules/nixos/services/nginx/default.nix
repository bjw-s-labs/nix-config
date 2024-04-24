{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.nginx;
in
{
  options.modules.services.nginx = {
    enable = lib.mkEnableOption "nginx";
    upstreams = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    virtualHosts = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      upstreams = cfg.upstreams;
      virtualHosts = cfg.virtualHosts;
    };
  };
}
