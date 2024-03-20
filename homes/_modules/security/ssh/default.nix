{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.security.ssh;
in
{
  options.modules.security.ssh = {
    enable = lib.mkEnableOption "ssh";
    matchBlocks = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      inherit (cfg) matchBlocks;

      controlMaster = "auto";
      controlPath = "~/.ssh/control/%C";

      includes = [
        "config.d/*"
      ];
    };
  };
}
