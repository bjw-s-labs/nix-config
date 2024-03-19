{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  cfg = config.modules.security.gnugpg;
in
{
  options.modules.security.gnugpg = {
    enable = lib.mkEnableOption "gnugpg";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.gpg = {
        enable = true;
        mutableKeys = true;
        mutableTrust = true;
        settings = {
          default-recipient-self = true;
          use-agent = true;
        };
      };
    })
    (lib.mkIf (cfg.enable && isDarwin) {
      home.packages = [
        pkgs.pinentry_mac
      ];
    })
    (lib.mkIf (cfg.enable && isLinux) {
      home.packages = [
        pkgs.pinentry-curses
      ];

      services.gpg-agent = {
        enable = true;
        pinentryFlavor = "curses";
      };

      programs = let
        fixGpg = ''
          gpgconf --launch gpg-agent
        '';
      in {
        bash.profileExtra = fixGpg;
        fish.loginShellInit = fixGpg;
        zsh.loginExtra = fixGpg;
      };
    })
  ];
}
