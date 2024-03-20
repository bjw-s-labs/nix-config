{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  extensions = let
    inherit (inputs.nix-vscode-extensions.extensions.${pkgs.system}) vscode-marketplace;
  in
    with vscode-marketplace; [
      # Themes
      catppuccin.catppuccin-vsc
      thang-nm.catppuccin-perfect-icons

      # Language support
      golang.go
      hashicorp.terraform
      jnoortheen.nix-ide
      mrmlnc.vscode-json5
      ms-azuretools.vscode-docker
      ms-python.python
      redhat.ansible
      redhat.vscode-yaml
      tamasfe.even-better-toml

      # Formatters
      esbenp.prettier-vscode

      # Remote development
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh

      # Other
      gruntfuggly.todo-tree
      ionutvmi.path-autocomplete
      luisfontes19.vscode-swissknife
      ms-kubernetes-tools.vscode-kubernetes-tools
      shipitsmarter.sops-edit
    ];
in
{
  modules = {
    deployment.nix.enable = true;
    development.enable = true;
    editor = {
      vscode = {
        enable = true;
        userSettings = lib.importJSON ../config/editor/vscode/settings.json;
        extensions = extensions;
      };
    };
    kubernetes.enable = true;
    security.gnugpg.enable = true;
    virtualisation = {
      colima = {
        enable = true;
        startService = true;
      };
      docker-cli.enable = true;
    };
  };
}
