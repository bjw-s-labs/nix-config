{
  pkgs,
  hostname,
  flake-packages,
  ...
}:
{
  imports = [
    ../_modules

    ./secrets
    ./hosts/${hostname}.nix
  ];

  modules = {
    editor = {
      nvim = {
        enable = true;
        package = flake-packages.${pkgs.system}.nvim;
        makeDefaultEditor = true;
      };
    };

    security = {
      ssh = {
        enable = true;
        matchBlocks = {
          "gateway.bjw-s.casa" = {
            port = 22;
            user = "vyos";
          };
          "gladius.bjw-s.casa" = {
            port = 22;
            user = "bjw-s";
            forwardAgent = true;
          };
        };
      };
    };

    shell = {
      fish.enable = true;

      git = {
        enable = true;
        username = "Bernd Schorgers";
        email = "me@bjw-s.dev";
        signingKey = "0x80FF2B2CE4316DEE";
      };

      go-task.enable = true;

      mise = {
        enable = true;
        package = pkgs.unstable.mise;
      };
    };
  };
}
