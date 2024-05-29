let
  ads-whitelist = builtins.toFile "ads-whitelist" ''
    rabobank.nl
  '';
in
{
  ports = {
    dns = "0.0.0.0:53";
    http = 4000;
  };
  bootstrapDns = [
    {
      upstream = "tcp-tls:1.1.1.1:853";
    }
  ];

  upstreams.groups.default = [
    # Cloudflare
    "tcp-tls:1.1.1.1:853"
    "tcp-tls:1.0.0.1:853"
  ];

  caching.cacheTimeNegative = -1;

  conditional = {
    fallbackUpstream = false;
    mapping = {
      "1.10.in-addr.arpa" = "10.1.0.1:53";
      "bjw-s.dev" = "127.0.0.1:5391";
      "internal" = "10.1.0.1:53";
    };
  };

  customDNS = {
    mapping = {
      "main.k8s.bjw-s.internal" = "10.1.1.30";
    };
  };

  # configuration of client name resolution
  clientLookup.upstream = "10.1.0.1:53";

  ecs.useAsClient = true;

  prometheus = {
    enable = true;
    path = "/metrics";
  };

  blocking = {
    loading.downloads.timeout = "4m";
    blackLists = {
      ads = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
      ];
      fakenews = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts"
      ];
      gambling = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-only/hosts"
      ];
    };

    whiteLists = {
      ads = [
        "file://${ads-whitelist}"
      ];
    };

    clientGroupsBlock = {
      default = [
        "ads"
        "fakenews"
        "gambling"
      ];
      "manyie*" = [
        "fakenews"
        "gambling"
      ];
    };
  };
}
