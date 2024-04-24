{
  config,
  ...
}:
''
include "${config.sops.secrets."networking/bind/rndc-key".path}";
include "${config.sops.secrets."networking/bind/externaldns-key".path}";
controls {
  inet 127.0.0.1 allow {localhost;} keys {"rndc-key";};
};

# Only define known networks as trusted
acl trusted {
  10.1.0.0/24;    # LAN
  10.1.1.0/24;    # SERVERS
  10.1.2.0/24;    # TRUSTED
  10.1.3.0/24;    # IOT
  10.1.4.0/24;    # VIDEO
  192.168.2.0/24; # GUEST
  10.0.11.0/24;   # WIREGUARD
};
acl badnetworks {  };

options {
  listen-on port 5354 { any; };
  directory "${config.services.bind.directory}";
  pid-file "${config.services.bind.directory}/named.pid";

  allow-recursion { trusted; };
  allow-transfer { none; };
  allow-update { none; };
  blackhole { badnetworks; };
  dnssec-validation auto;
};

logging {
  channel stdout {
    stderr;
    severity info;
    print-category yes;
    print-severity yes;
    print-time yes;
  };
  category security { stdout; };
  category dnssec   { stdout; };
  category default  { stdout; };
};

zone "bjw-s.dev." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/bjw-s.dev".path}";
  journal "${config.services.bind.directory}/db.bjw-s.dev.jnl";
  allow-transfer {
    key "externaldns";
  };
  update-policy {
    grant externaldns zonesub ANY;
  };
};

zone "bjw-s.casa." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/bjw-s.casa".path}";
  journal "${config.services.bind.directory}/db.bjw-s.casa.jnl";
};

zone "1.10.in-addr.arpa." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/1.10.in-addr.arpa".path}";
  journal "${config.services.bind.directory}/db.1.10.in-addr.arpa.jnl";
};

zone "unifi." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/unifi".path}";
  journal "${config.services.bind.directory}/db.unifi.jnl";
};
''
