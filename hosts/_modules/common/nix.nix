{
  inputs,
  lib,
  ...
}:
{
  nix = {
    settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://numtide.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];

      # Fallback quickly if substituters are not available.
      connect-timeout = 5;

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      warn-dirty = false;

      # The default at 10 is rarely enough.
      log-lines = lib.mkDefault 25;

      # Avoid disk full issues
      max-free = lib.mkDefault (1000 * 1000 * 1000);
      min-free = lib.mkDefault (128 * 1000 * 1000);

      # Avoid copying unnecessary stuff over SSH
      builders-use-substitutes = true;
    };

    # Add nixpkgs input to NIX_PATH
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];

    # garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 2d";
    };
  };
}
