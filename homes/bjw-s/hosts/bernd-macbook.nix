{
  lib,
  pkgs,
  ...
}:
{
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
      mise = {
        enable = true;
        package = pkgs.unstable.mise;
        globalConfig = {
          tools = {
            python = "latest";
            node = "latest";
            go = "latest";
          };
        };
      };
    };
  };
}
