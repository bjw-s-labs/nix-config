{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.virtualisation.docker-cli;
in
{
  options.modules.virtualisation.docker-cli = {
    enable = lib.mkEnableOption "docker-cli";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.docker-buildx
      pkgs.docker-client
      pkgs.docker-compose
    ];
  };
}
