{ pkgs, pkgs-unstable, ... }:

let
  vscode-extensions = (import ../../editor/vscode/extensions.nix){pkgs = pkgs;};
in
{
  modules.users.bjw-s.editor.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;

    extensions = (with vscode-extensions; [
      eamodio.gitlens
      golang.go
      fnando.linter
      github.copilot
      hashicorp.terraform
      jnoortheen.nix-ide
      mrmlnc.vscode-json5
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      redhat.ansible
      ms-python.python
      ms-python.vscode-pylance
    ]);

    config = {
      # Extension settings
      ansible = {
        python.interpreterPath = ".venv/bin/python";
      };

      linter = {
        linters = {
          yamllint = {
            configFiles = [
              ".yamllint.yml"
              ".yamllint.yaml"
              ".yamllint"
              ".ci/yamllint/.yamllint.yaml"
            ];
          };
        };
      };

      qalc = {
        output.displayCommas = false;
        output.precision = 0;
        output.notation = "auto";
      };
    };
  };

  modules.users.bjw-s.shell.rtx = {
    enable = true;
    package = pkgs-unstable.rtx;
  };

  modules.users.bjw-s.virtualisation.colima = {
    enable = true;
    enableService = true;
    package = pkgs-unstable.colima;
  };

  home-manager.users.bjw-s.home.packages = [
    pkgs.envsubst
    pkgs.go-task
  ];
}
