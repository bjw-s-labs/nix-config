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
        onepassword-credentials = {
          mode = "0444";
        };
        "users/bjw-s/password" = {
          neededForUsers = true;
        };
      };
    };
  };
}
