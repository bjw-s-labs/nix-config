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
  nvim = callPackage ./nvim.nix inputs;
  shcopy = callPackage ./shcopy.nix inputs;
  usage = callPackage ./usage.nix inputs;
}
