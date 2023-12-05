{ username }: {lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.virtualisation.docker;
in {
  options.modules.users.${username}.virtualisation.docker = {
    enable = mkEnableOption "${username} docker";
    package = mkPackageOption pkgs "docker" { };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [
        cfg.package
        pkgs.docker-buildx
        pkgs.docker-client
        pkgs.docker-compose
      ];
    };
  };
}
