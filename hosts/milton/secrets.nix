{
  pkgs,
  config,
  ...
}:
{
  config = {
    environment.systemPackages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      age.sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
      secrets = {
        onepassword-credentials = {
          mode = "0444";
        };
        "networking/bind/rndc-key" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/externaldns-key" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/bjw-s.dev" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/bjw-s.casa" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/unifi" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/1.10.in-addr.arpa" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
      };
    };
  };
}
