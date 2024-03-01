{ username }: args@{pkgs, lib, myLib, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.shell.btop;
in {
   options.modules.users.${username}.shell.btop = {
    enable = mkEnableOption "${username} btop";
    enableFishIntegration = mkEnableOption "${username} btop fish integration";
    package = mkPackageOption pkgs "btop" { };
  };

  config = mkIf (cfg.enable) ({
    environment.systemPackages = [
      cfg.package
    ];

    home-manager.users.${username}.programs.fish = mkIf (cfg.enableFishIntegration) ({
      shellAliases = {
        top = "btop";
      };
    });
  });
}
