{ username }: {lib, pkgs, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.virtualisation.docker-cli;
in {
  options.modules.users.${username}.virtualisation.docker-cli = {
    enable = mkEnableOption "${username} docker-cli";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [
        pkgs.docker-buildx
        pkgs.docker-client
        pkgs.docker-compose
      ];
    };
  };
}
