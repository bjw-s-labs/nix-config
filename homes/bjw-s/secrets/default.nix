{
  pkgs,
  config,
  ...
}: let
  ageKeyFile = "${config.xdg.configHome}/age/keys.txt";
in {
  config = {
    home.packages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      age.sshKeyPaths = [
        ageKeyFile
      ];
      secrets = {
        atuin_key = {
          path = "${config.xdg.configHome}/atuin/key";
        };
      };
    };

    home.sessionVariables = {
      SOPS_AGE_KEY_FILE = ageKeyFile;
    };
  };
}
