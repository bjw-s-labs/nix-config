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

      programs.krewfile = {
        enable = true;
        krewPackage = krewPackage;
        plugins = [
          "browse-pvc"
          "get-all"
          "netshoot/netshoot"
          "pv-migrate"
          "rook-ceph"
          "view-secret"
        ];
      };

      programs.fish = {
        interactiveShellInit = ''
          fish_add_path $HOME/.krew/bin
        '';
      };
    })
  ];
}
