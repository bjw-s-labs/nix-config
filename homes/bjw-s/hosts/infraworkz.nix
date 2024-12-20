{
  config,
  pkgs,
  lib,
  ...
}:
{
  sops.secrets = {
    "work/git_config" = {
      path = "${config.xdg.configHome}/git/work_config";
    };
    "work/git_config_client_1" = {
      path = "${config.xdg.configHome}/git/git_config_client_1";
    };
  };

  modules = {
    deployment.nix.enable = true;
    development.enable = true;
    editor = {
      vscode = {
        enable = true;
        userSettings = lib.importJSON ../config/editor/vscode/settings.json;
      };
    };
    kubernetes.enable = true;
    security.gnugpg.enable = true;
    security._1password-cli.enable = true;
    shell = {
      git = {
        includes = [
          {
            path = "${config.xdg.configHome}/git/work_config";
          }
        ];
      };
      mise = {
        enable = true;
        package = pkgs.unstable.mise;
        globalConfig = {
          tools = {
            python = "latest";
            node = "latest";
          };
        };
      };
    };
  };
}
