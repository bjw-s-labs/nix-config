{ username }: args@{lib, pkgs, config, system, ... }:
with lib;
let
  cfg = config.modules.users.${username}.virtualisation.colima;
in {
  options.modules.users.${username}.virtualisation.colima = {
    enable = mkEnableOption "${username} colima";
    package = mkPackageOption pkgs "colima" { };
    enableService = mkEnableOption "${username} colima service";
  };

  config = mkIf (cfg.enable) (mkMerge [
    {
      home-manager.users.${username} = {
        home.packages = [
          cfg.package
        ];
      };
      modules.users.bjw-s.virtualisation.docker-cli.enable = true;
    }

    (mkIf (pkgs.stdenv.isDarwin) (import ./darwin.nix {username=username;} args))
  ]);
}
