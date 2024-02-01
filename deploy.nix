{ self
, deploy-rs
, nixpkgs
, ...
}:
let
  inherit (nixpkgs) lib;

  genNode = hostName: nixosCfg:
    let
      inherit (self.hosts.${hostName}) address hostPlatform remoteBuild type;
      inherit (deploy-rs.lib.${hostPlatform}) activate;
    in
    {
      profiles.system.path = activate.${type} nixosCfg;
      inherit remoteBuild;
      hostname = address;
    };
in
{
  autoRollback = false;
  magicRollback = true;
  sshOpts = [
    "-A"
  ];
  user = "root";
  nodes = lib.mapAttrs
    genNode (self.nixosConfigurations or { });
}
