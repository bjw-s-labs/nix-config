{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.kubernetes;
  krewPackage = pkgs.unstable.krew;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        krewPackage
      ];

      programs.fish = {
        interactiveShellInit = ''
          fish_add_path $HOME/.krew/bin
        '';
      };
    })
  ];
}
