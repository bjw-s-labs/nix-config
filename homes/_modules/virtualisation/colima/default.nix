{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.virtualisation.colima;
  package = pkgs.unstable.colima;
in
{
  options.modules.virtualisation.colima = {
    enable = lib.mkEnableOption "colima";
    startService = lib.mkEnableOption "colima service";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.enable && cfg.startService) {
      launchd.agents.colima = {
        enable = true;
        config = {
          EnvironmentVariables = {
            PATH = "/Users/${config.home.username}/.nix-profile/bin:/etc/profiles/per-user/${config.home.username}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
          };
          ProgramArguments = lib.mkMerge [
            [
            "${package}/bin/colima"
            "start"
            "--foreground"
            ]

            (lib.mkIf (pkgs.system == "aarch64-darwin") [
              "--arch" "aarch64"
              "--vm-type" "vz"
              "--vz-rosetta"
            ])
          ];
          KeepAlive = {
            Crashed = true;
            SuccessfulExit = false;
          };
          ProcessType = "Interactive";
        };
      };
    })

    (lib.mkIf cfg.enable {
      home.packages = [
        package
      ];

      programs.ssh = {
        includes = [
          "/Users/${config.home.username}/.colima/ssh_config"
        ];
      };
    })
  ];
}
