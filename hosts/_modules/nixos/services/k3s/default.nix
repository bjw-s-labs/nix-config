{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.k3s;
in
{
  options.modules.services.k3s = {
    enable = lib.mkEnableOption "k3s";
    package = lib.mkPackageOption pkgs "k3s" { };
    extraFlags = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra flags to pass to k3s";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      6443
    ];

    services.k3s = {
      enable = true;
      role = "server";
      inherit (cfg) package;
    };

    services.k3s.extraFlags = toString ([
      "--disable=local-storage"
      "--disable=traefik"
      "--disable=metrics-server"
    ] ++ cfg.extraFlags);

    environment.systemPackages = [ cfg.package ];
  };
}
