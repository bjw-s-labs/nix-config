{ username }: args@{pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.shell.fish;

  defaultConfig = (import ./defaultConfig.nix args);
in {
   options.modules.users.${username}.shell.fish = {
    enable = mkEnableOption "${username} fish";

    config = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = mkIf (cfg.enable) (mkMerge [
    {
      programs.fish.enable = true;

      home-manager.users.${username} = mkIf (cfg.enable) (mkMerge [
        defaultConfig
        cfg.config
      ]);
    }

    {
      programs.fish.interactiveShellInit = ''
        fish_add_path ~/.local/bin
      '';
    }

    (import ../packages/default.nix args)

    # Fix for https://github.com/LnL7/nix-darwin/issues/122
    (mkIf (pkgs.stdenv.isDarwin) (import ./darwin.nix args))
  ]);
}
