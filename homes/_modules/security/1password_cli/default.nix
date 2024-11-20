{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.security._1password-cli;
in
{
  options.modules.security._1password-cli = {
    enable = lib.mkEnableOption "1password_cli";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        pkgs._1password-cli
      ];
    })
  ];
}
