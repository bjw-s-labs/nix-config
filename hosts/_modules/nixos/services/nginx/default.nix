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
    enableAcme = lib.mkEnableOption "nginx";
    upstreams = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    virtualHosts = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };

    acmeCloudflareAuthFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      inherit (cfg) upstreams;
      virtualHosts = cfg.virtualHosts // {
        "_" = {
          root = "/var/www/placeholder";
        };
      };
    };

    security.acme = lib.mkIf cfg.enableAcme  {
      acceptTerms = true;
      defaults = {
        email = "postmaster@bjw-s.dev";
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        environmentFile = cfg.acmeCloudflareAuthFile;
      };
    };
  };
}
