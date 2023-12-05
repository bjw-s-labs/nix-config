{ username }: {lib, config, ... }:
with lib;
let
  cfg = config.modules.users.${username}.home-manager;
in
{
  imports = [
    ( import ../sops {username=username;} )

    ( import ../editor/nvim {username=username;} )
    ( import ../editor/vscode {username=username;} )

    ( import ../kubernetes/k9s {username=username;} )
    ( import ../kubernetes/krew {username=username;} )
    ( import ../kubernetes/kubecm {username=username;} )
    ( import ../kubernetes/stern {username=username;} )

    ( import ../shell/atuin {username=username;} )
    ( import ../shell/fish {username=username;} )
    ( import ../shell/git {username=username;} )
    ( import ../shell/rtx {username=username;} )
    ( import ../shell/starship {username=username;} )
    ( import ../shell/tmux {username=username;} )

    ( import ../virtualisation/colima {username=username;} )
    ( import ../virtualisation/docker-cli {username=username;} )
  ];

  options.modules.users.${username}.home-manager = {
    enable = mkEnableOption "${username} home-manager";
  };

  config = mkMerge [
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }

    (mkIf (cfg.enable) {
      home-manager.users.${username} = {
        home = {
          stateVersion = "23.11";
        };

        programs = {
          home-manager.enable = true;
        };
      };
    })
  ];
}
