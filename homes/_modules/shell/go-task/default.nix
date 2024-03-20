{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.go-task;
in {
  options.modules.shell.go-task = {
    enable = lib.mkEnableOption "go-task";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        pkgs.go-task
      ];
    })
  ];
}
