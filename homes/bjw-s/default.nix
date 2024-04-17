{
  pkgs,
  lib,
  inputs,
  hostname,
  flake-packages,
  ...
}:
{
  imports = [
    ../_modules

    ./secrets
    ./hosts/${hostname}.nix
  ];

  modules = {
    editor = {
      nvim = {
        enable = true;
        package = flake-packages.${pkgs.system}.nvim;
        makeDefaultEditor = true;
      };

      vscode = {
        userSettings = lib.importJSON ./config/editor/vscode/settings.json;
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

            # Linters
            davidanson.vscode-markdownlint
            fnando.linter

            # Remote development
            ms-vscode-remote.remote-containers
            ms-vscode-remote.remote-ssh

            # Other
            eamodio.gitlens
            gruntfuggly.todo-tree
            ionutvmi.path-autocomplete
            luisfontes19.vscode-swissknife
            ms-kubernetes-tools.vscode-kubernetes-tools
            shipitsmarter.sops-edit
          ];
      };
    };

    security = {
      ssh = {
        enable = true;
        matchBlocks = {
          "gateway.bjw-s.casa" = {
            port = 22;
            user = "vyos";
          };
          "gladius.bjw-s.casa" = {
            port = 22;
            user = "bjw-s";
            forwardAgent = true;
          };
        };
      };
    };

    shell = {
      fish.enable = true;

      git = {
        enable = true;
        username = "Bernd Schorgers";
        email = "me@bjw-s.dev";
        signingKey = "0x80FF2B2CE4316DEE";
      };

      go-task.enable = true;

      mise = {
        enable = true;
        package = pkgs.unstable.mise;
      };
    };

    themes = {
      catppuccin = {
        enable = true;
        flavour = "macchiato";
      };
    };
  };
}
