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
    flavor = lib.mkOption {
      type = lib.types.str;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    catppuccin.flavor = cfg.flavor;
  };
}
