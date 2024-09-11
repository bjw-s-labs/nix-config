{
  lib,
  config,
  pkgs,
  flake-packages,
  ...
}:
let
  cfg = config.modules.kubernetes;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = (with pkgs.unstable; [
        kubectl
        kubectl-neat
        kubectl-node-shell
        kubectl-view-secret
      ]) ++ (with flake-packages.${pkgs.system};[
        kubectl-browse-pvc
        kubectl-get-all
        kubectl-netshoot
      ]);

      programs.fish = {
        functions = {
          kyaml = {
            description = "Clean up kubectl get yaml output";
            body = ''
              kubectl get $argv -o yaml | kubectl-neat
            '';
          };
        };
        shellAliases = {
          k = "kubectl";
        };
      };
    })
  ];
}
