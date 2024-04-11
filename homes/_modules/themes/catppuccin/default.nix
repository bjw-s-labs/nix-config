{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.themes.catppuccin;
in
{
  options.modules.themes.catppuccin = {
    enable = lib.mkEnableOption "catppuccin";
    flavour = lib.mkOption {
      type = lib.types.str;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    catppuccin.flavour = cfg.flavour;
  };
}
