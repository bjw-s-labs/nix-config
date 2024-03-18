{ username }: args@{pkgs, lib, myLib, config, vscode-extensions, ... }:
with lib;

let
  cfg = config.modules.users.${username}.editor.vscode;

  userDir = if pkgs.stdenv.hostPlatform.isDarwin then
    "Library/Application Support/Code/User"
  else
    "${config.xdg.configHome}/Code/User";
  configFilePath = "${userDir}/settings.json";

  defaultConfig = (import ./defaultConfig.nix args);

in {
   options.modules.users.${username}.editor.vscode = {
    enable = mkEnableOption "${username} vscode";
    package = mkPackageOption pkgs "vscode" { };

    config = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {lib, ... }: mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        package = cfg.package;
        enableExtensionUpdateCheck = false;

        userSettings = myLib.recursiveMerge [
          defaultConfig
          cfg.config
        ];
      };

      home = {
        activation = {
          removeExistingVSCodeSettings = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
            rm -rf "${configFilePath}"
          '';

          overwriteVSCodeSymlink = let
            userSettings = config.home-manager.users.${username}.programs.vscode.userSettings;
            jsonSettings = pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings);
          in lib.hm.dag.entryAfter [ "linkGeneration" ] ''
            rm -rf "${configFilePath}"
            cat ${jsonSettings} | ${pkgs.jq}/bin/jq --monochrome-output > "${configFilePath}"
          '';
        };
      };
    };
  };
}
