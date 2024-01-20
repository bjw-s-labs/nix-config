{ pkgs, ... }: {
  harlequin = pkgs.callPackage ./harlequin/default.nix {};
}
