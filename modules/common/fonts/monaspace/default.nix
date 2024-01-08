{ username }: {pkgs, lib, config, ... }:
with lib;

let
  cfg = config.modules.users.${username}.fonts.monaspace;

in {
   options.modules.users.${username}.fonts.monaspace = {
    enable = mkEnableOption "${username} monaspace";
    package = mkPackageOption pkgs "monaspace" { };
  };

  config.home-manager.users.${username} = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
