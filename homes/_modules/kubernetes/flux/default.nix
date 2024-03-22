{
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
      programs.fish = {
        interactiveShellInit = ''
          flux completion fish | source
        '';
      };
    })
  ];
}
