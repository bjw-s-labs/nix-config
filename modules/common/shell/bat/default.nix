{ username }: args@{pkgs, lib, myLib, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.shell.bat;
  defaultConfig = import ./defaultConfig.nix {};
in {
   options.modules.users.${username}.shell.bat = {
    enable = mkEnableOption "${username} bat";

    enableFishIntegration = mkEnableOption "${username} bat fish integration";

    config = mkOption {
      type = with types; attrsOf (oneOf [ str (listOf str) bool ]);
      default = {};
    };
  };

  config = {
    home-manager.users.${username}.programs = mkIf (cfg.enable) ({
      bat = {
        enable = true;
        config = myLib.recursiveMerge [
          defaultConfig
          cfg.config
        ];
        themes = {
          catppuccin-macchiato = {
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
            };
            file = "Catppuccin-macchiato.tmTheme";
          };
        };
      };

      fish = mkIf (cfg.enableFishIntegration) ({
        shellAliases = {
          cat = "bat";
        };
      });
    });
  };
}
