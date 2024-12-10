{
  pkgs,
  lib,
  config,
  inputs,
  hostname,
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
        makeDefaultEditor = true;
      };

      vscode = {
        userSettings = lib.importJSON ./config/editor/vscode/settings.json;
        extensions = (with pkgs.unstable.vscode-extensions; [
          # Remote development
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
        ]) ++
        (let
          inherit (inputs.nix-vscode-extensions.extensions.${pkgs.system}) vscode-marketplace;
        in
          with vscode-marketplace; [
            # Language support
            golang.go
            helm-ls.helm-ls
            jnoortheen.nix-ide
            ms-azuretools.vscode-docker
            ms-python.python
            redhat.vscode-yaml
            savh.json5-kit
            tamasfe.even-better-toml

            # Formatters
            esbenp.prettier-vscode

            # Linters
            davidanson.vscode-markdownlint
            fnando.linter

            # Other
            eamodio.gitlens
            gruntfuggly.todo-tree
            ionutvmi.path-autocomplete
            luisfontes19.vscode-swissknife
            ms-kubernetes-tools.vscode-kubernetes-tools
            signageos.signageos-vscode-sops
          ]
        );
      };
    };

    security = {
      ssh = {
        enable = true;
        matchBlocks = {
          "gladius.bjw-s.internal" = {
            port = 22;
            user = "bjw-s";
            forwardAgent = true;
          };
        };
      };
    };

    shell = {
      atuin = {
        enable = true;
        package = pkgs.unstable.atuin;
        flags = [
          "--disable-up-arrow"
        ];
        settings = {
          sync_address = "https://atuin.bjw-s.dev";
          key_path = config.sops.secrets.atuin_key.path;
          auto_sync = true;
          sync_frequency = "1m";
          search_mode = "fuzzy";
          sync = {
            records = true;
          };
        };
      };

      fish.enable = true;

      git = {
        enable = true;
        username = "Bernd Schorgers";
        email = "me@bjw-s.dev";
        signingKey = "0x80FF2B2CE4316DEE";
      };

      go-task.enable = true;
    };

    themes = {
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
}
