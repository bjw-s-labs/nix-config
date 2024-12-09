# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  pkgs ? import <nixpkgs> {},
  ...
}:
{
  kubecolor-catppuccin = pkgs.callPackage ./kubecolor-catppuccin {};
  kubectl-pgo = pkgs.callPackage ./kubectl-pgo {};
  shcopy = pkgs.callPackage ./shcopy {};
  talhelper = inputs.talhelper.packages.${pkgs.system}.default;
  talosctl = pkgs.callPackage ./talosctl {};
  usage = pkgs.callPackage ./usage {};
}
