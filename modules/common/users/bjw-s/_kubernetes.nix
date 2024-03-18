{
  pkgs-unstable,
  ...
}:
{
  modules.users.bjw-s.kubernetes.k9s = {
    enable = true;
    package = pkgs-unstable.k9s;
    config = {
      k9s = {
        ui = {
          skin = "catppuccin-macchiato";
        };
      };
    };
  };
  modules.users.bjw-s.kubernetes.krew.enable = true;
  modules.users.bjw-s.kubernetes.kubecm = {
    enable = true;
    package = pkgs-unstable.kubecm;
  };
  modules.users.bjw-s.kubernetes.stern.enable = true;

  modules.users.bjw-s.shell.fish = {
    config.programs.fish = {
      shellAliases = {
        k = "kubectl";
      };
      interactiveShellInit = ''
        flux completion fish | source
      '';
    };
  };

  modules.users.bjw-s.editor.vscode = {
    config = {
      vs-kubernetes = {
        "vs-kubernetes.crd-code-completion" = "disabled";
      };
    };
  };
}
