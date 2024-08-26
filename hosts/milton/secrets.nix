{
  pkgs,
  config,
  ...
}:
{
  config = {
    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      secrets = {
        "users/bjw-s/password" = {
          neededForUsers = true;
        };
      };
    };
  };
}
