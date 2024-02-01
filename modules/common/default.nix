{ hostName, pkgs, ... }:
{
  imports = [
    ./device.nix

    ./users
    ./users/bjw-s
    ./users/manyie
  ];

  networking.hostName = hostName;

  time.timeZone = "Europe/Amsterdam";

  nix = {
    settings = {
      accept-flake-config = true;
      builders-use-substitutes = true;
      cores = 0;
      experimental-features = [ "nix-command" "flakes" ];
      max-jobs = "auto";
      substituters = [
        "https://bjw-s.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "bjw-s.cachix.org-1:dWyzjMYlnKeq01PplRWadakXfZQBoxJN7zGO6/HwsPs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      # Delete older generations too
      options = "--delete-older-than 2d";
    };
  };

  environment.systemPackages = with pkgs; [
    gnused
    gnugrep
  ];
}
