{
  self,
  deploy-rs,
  ...
}:
let
  deployConfig = name: system: cfg: {
    hostname = "${name}.bjw-s.casa";
    sshOpts = cfg.sshOpts or [];

    profiles = {
      system = {
        sshUser = cfg.sshUser;
        path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${name};
        user = "root";
      };
    };

    remoteBuild = cfg.remoteBuild or false;
    autoRollback = cfg.autoRollback or false;
    magicRollback = cfg.magicRollback or true;
  };
in
{
  deploy.nodes = {
    gladius = deployConfig "gladius" "x86_64-linux" {sshUser = "bjw-s"; remoteBuild = true;};
  };
  checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
}
