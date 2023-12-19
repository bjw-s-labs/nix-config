{ pkgs, lib, config, ... }:
with lib;

let
  deviceCfg = config.modules.device;
  cfg = config.modules.servers.k3s;
in {
  options.modules.servers.k3s = {
    enable = mkEnableOption "k3s";
    package = mkPackageOption pkgs "k3s" { };
    extraFlags = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Extra flags to pass to k3s";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 6443 ];

    services.k3s = {
      enable = true;
      role = "server";
      package = cfg.package;
    };

    services.k3s.extraFlags = toString ([
      "--tls-san=${config.networking.hostName}.${deviceCfg.domain}"
      "--disable=local-storage"
      "--disable=traefik"
      "--disable=metrics-server"
    ] ++ cfg.extraFlags);

    environment.systemPackages = [ cfg.package ];
  };
}
