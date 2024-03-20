{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.editor.nvim;
in
{
  options.modules.editor.nvim = {
    enable = lib.mkEnableOption "nvim";
    package = lib.mkPackageOption pkgs "neovim" { };
    makeDefaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        cfg.package
      ];
    })

    (lib.mkIf (cfg.enable && cfg.makeDefaultEditor) {
      # Use Neovim as the editor for git commit messages
      programs.git.extraConfig.core.editor = "nvim";

      # Set Neovim as the default app for text editing and manual pages
      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };

      programs.fish = {
        shellAliases = {
          vi = "nvim";
          vim = "nvim";
        };
      };
    })
  ];
}
