{ pkgs, ... }: {
  harlequin = pkgs.callPackage ./harlequin/default.nix {};
  mise = pkgs.callPackage ./mise/default.nix {};
}
