{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.kubernetes;
  package = pkgs.unstable.kubecm.overrideAttrs (_: prev: {
    meta = prev.meta // {
      mainProgram = "kubecm";
    };
  });
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        package
      ];

      programs.fish = {
        interactiveShellInit = ''
          ${lib.getExe package} completion fish | source
        '';

        shellAliases = {
          kc = "kubecm";
        };
      };
    })
  ];
}
