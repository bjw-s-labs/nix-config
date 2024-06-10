{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.openssh;
in
{
  options.modules.services.openssh = {
    enable = lib.mkEnableOption "openssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      # Don't allow home-directory authorized_keys
      authorizedKeysFiles = lib.mkForce ["/etc/ssh/authorized_keys.d/%u"];
      settings = {
        # Harden
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
      };
    };

    # Passwordless sudo when SSH'ing with keys
    security.pam.sshAgentAuth = {
      enable = true;
      authorizedKeysFiles = [
        "/etc/ssh/authorized_keys.d/%u"
      ];
    };
  };
}
