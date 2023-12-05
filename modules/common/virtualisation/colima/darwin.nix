{ username }: { config, lib, system, ... }:
with lib;
let
  cfg = config.modules.users.${username}.virtualisation.colima;
in
{
  home-manager.users.${username} = mkMerge [
    (mkIf (cfg.enableService) {
      launchd.agents.colima = {
        enable = true;
        config = {
          EnvironmentVariables = {
            PATH = "/Users/${username}/.nix-profile/bin:/etc/profiles/per-user/${username}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin:/usr/sbin:/sbin";
          };
          ProgramArguments = mkMerge [
            [
            "${cfg.package}/bin/colima"
            "start"
            "--foreground"
            ]

            (mkIf (system == "aarch64-darwin") [
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
  ];
}
