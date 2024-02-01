{
  nixpkgs,
  ...
}:
nixpkgs.lib.makeExtensible (self: {
  recursiveMerge = import ./recursivemerge.nix {inherit (nixpkgs) lib;};
})
