{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.minio;
in
{
  options.modules.services.minio = {
    enable = lib.mkEnableOption "minio";
    package = lib.mkPackageOption pkgs "minio" { };
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/minio/data";
    };
    rootCredentialsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };
    enableReverseProxy = lib.mkEnableOption "minio-reverseProxy";
    minioConsoleURL = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    minioS3URL  = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    modules.services.nginx = lib.mkIf cfg.enableReverseProxy {
      enable = true;
      virtualHosts = {
        "${cfg.minioS3URL}" = {
          enableACME = config.modules.services.nginx.enableAcme;
          acmeRoot = null;
          forceSSL = config.modules.services.nginx.enableAcme;
          extraConfig = ''
            client_max_body_size 0;
            proxy_buffering off;
            proxy_request_buffering off;
          '';
          locations."/" = {
            proxyPass = "http://127.0.0.1:9000/";
          };
        };
        "${cfg.minioConsoleURL}" = {
          enableACME = config.modules.services.nginx.enableAcme;
          acmeRoot = null;
          forceSSL = config.modules.services.nginx.enableAcme;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9001/";
            extraConfig = ''
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
            '';
          };
        };
      };
    };

    services.minio = {
      enable = true;
      inherit (cfg) package;
      dataDir = [
        cfg.dataDir
      ];
      inherit (cfg) rootCredentialsFile;
    };
  };
}
