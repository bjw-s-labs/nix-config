{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.kubernetes;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        pkgs.unstable.krew
      ];

      programs.fish = {
        interactiveShellInit = ''
          fish_add_path $HOME/.krew/bin
        '';
      };
    })
  ];
}
