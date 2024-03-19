{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.deployment.nix;
in
{
  options.modules.deployment.nix = {
    enable = lib.mkEnableOption "nix-deployment";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.deploy-rs.deploy-rs
      pkgs.nixos-rebuild
      pkgs.nvd
    ];
  };
}
