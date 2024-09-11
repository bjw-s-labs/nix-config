# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  pkgs ? (import ../nixpkgs.nix) {},
  ...
} @inputs :
let
  inherit (pkgs) callPackage;
in
{
  kubectl-browse-pvc = callPackage ./kubectl-browse-pvc.nix inputs;
  kubectl-get-all = callPackage ./kubectl-get-all.nix inputs;
  kubectl-netshoot = callPackage ./kubectl-netshoot.nix inputs;
  nvim = callPackage ./nvim.nix inputs;
  shcopy = callPackage ./shcopy.nix inputs;
  usage = callPackage ./usage.nix inputs;
}
