{
  lib,
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
  };
}
