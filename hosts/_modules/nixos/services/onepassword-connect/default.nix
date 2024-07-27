{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.onepassword-connect;
in
{
  options.modules.services.onepassword-connect = {
    enable = lib.mkEnableOption "onepassword-connect";
    apiVersion = lib.mkOption {
      type = lib.types.string;
      # renovate: depName=docker.io/1password/connect-api datasource=docker
      default = "1.7.3";
    };
    syncVersion = lib.mkOption {
      type = lib.types.string;
      # renovate: depName=docker.io/1password/connect-sync datasource=docker
      default = "1.7.3";
    };
    credentialsFile = lib.mkOption {
      type = lib.types.path;
    };
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/onepassword-connect/data";
    };
  };

  config = lib.mkIf cfg.enable {
    modules.services.podman.enable = true;

    system.activationScripts.makeOnePasswordConnectDataDir = lib.stringAfter [ "var" ] ''
      mkdir -p "${cfg.dataDir}"
      chown -R 999:999 ${cfg.dataDir}
    '';

    virtualisation.oci-containers.containers = {
      onepassword-connect-api = {
        image = "docker.io/1password/connect-api:${cfg.apiVersion}";
        autoStart = true;
        ports = [ "8080:8080" ];
        volumes = [
          "${cfg.credentialsFile}:/home/opuser/.op/1password-credentials.json"
          "${cfg.dataDir}:/home/opuser/.op/data"
        ];
      };

      onepassword-connect-sync = {
        image = "docker.io/1password/connect-sync:${cfg.syncVersion}";
        autoStart = true;
        ports = [ "8081:8080" ];
        volumes = [
          "${cfg.credentialsFile}:/home/opuser/.op/1password-credentials.json"
          "${cfg.dataDir}:/home/opuser/.op/data"
        ];
      };
    };
  };
}
