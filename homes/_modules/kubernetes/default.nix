{
  lib,
  ...
}:
{
  imports = [
    ./flux
    ./helmfile
    ./k9s
    ./krew
    ./kubecm
    ./kubeconform
    ./kubectl
    ./stern
  ];

  options.modules.kubernetes = {
    enable = lib.mkEnableOption "kubernetes";
  };
}
