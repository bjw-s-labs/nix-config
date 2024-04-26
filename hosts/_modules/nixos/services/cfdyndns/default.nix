{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.cfdyndns;
in
{
  options.modules.services.cfdyndns = {
    enable = lib.mkEnableOption "cfdyndns";
    package = lib.mkPackageOption pkgs "cfdyndns" { };
    apiTokenFile = lib.mkOption {
      type = lib.types.path;
    };
    records = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
    };
    recordsFile = lib.mkOption {
      type = lib.types.path;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.cfdyndns = {
      description = "CloudFlare Dynamic DNS Client";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      startAt = "*:0/5";
      serviceConfig = {
        Type = "simple";
        LoadCredential = [
          "CLOUDFLARE_APITOKEN_FILE:${cfg.apiTokenFile}"
        ] ++ lib.optionals (cfg.recordsFile != null) [
          "CLOUDFLARE_RECORDS_FILE:${cfg.recordsFile}"
        ];
        DynamicUser = true;
      };
      script = ''
        export CLOUDFLARE_APITOKEN="$(${pkgs.systemd}/bin/systemd-creds cat CLOUDFLARE_APITOKEN_FILE)"
        ${lib.optionalString (cfg.recordsFile != null) ''
          export CLOUDFLARE_RECORDS="$(${pkgs.systemd}/bin/systemd-creds cat CLOUDFLARE_RECORDS_FILE)"
        ''}
        ${lib.optionalString (cfg.records != null) ''
          export CLOUDFLARE_RECORDS="${lib.concatStringsSep "," cfg.records}"
        ''}
        ${cfg.package}/bin/cfdyndns
      '';
    };
  };
}
