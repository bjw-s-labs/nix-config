{
  pkgs,
  lib,
  config,
  hostname,
  ...
}:
let
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  config = {
    networking = {
      hostName = hostname;
      hostId = "775b7d55";
      useDHCP = true;
      firewall.enable = false;
    };

    users.users.bjw-s = {
      uid = 1000;
      name = "bjw-s";
      home = "/home/bjw-s";
      group = "bjw-s";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ../../homes/bjw-s/config/ssh/ssh.pub);
      hashedPasswordFile = config.sops.secrets."users/bjw-s/password".path;
      isNormalUser = true;
      extraGroups =
        [
          "wheel"
          "users"
        ]
        ++ ifGroupsExist [
          "network"
          "samba-users"
        ];
    };
    users.groups.bjw-s = {
      gid = 1000;
    };

    system.activationScripts.postActivation.text = ''
      # Must match what is in /etc/shells
      chsh -s /run/current-system/sw/bin/fish bjw-s
    '';

    modules = {
      filesystems.zfs = {
        enable = true;
        mountPoolsAtBoot = [
          "tank"
        ];
      };

      services = {
        chrony = {
          enable = true;
          servers = [
            "0.nl.pool.ntp.org"
            "1.nl.pool.ntp.org"
            "2.nl.pool.ntp.org"
            "3.nl.pool.ntp.org"
          ];
        };

        nginx = {
          enableAcme = true;
          acmeCloudflareAuthFile = config.sops.secrets."networking/cloudflare/auth".path;
        };

        minio = {
          enable = true;
          package = pkgs.unstable.minio;
          rootCredentialsFile = config.sops.secrets."storage/minio/root-credentials".path;
          dataDir = "/tank/Apps/minio";
          enableReverseProxy = true;
          minioConsoleURL = "minio.bjw-s.dev";
          minioS3URL = "s3.bjw-s.dev";
        };

        nfs.enable = true;

        node-exporter.enable = true;

        openssh.enable = true;

        samba = {
          enable = true;
          shares = {
            Backup = {
              path = "/tank/Backup";
              "read only" = "no";
            };
            Docs = {
              path = "/tank/Docs";
              "read only" = "no";
            };
            Media = {
              path = "/tank/Media";
              "read only" = "no";
            };
            Paperless = {
              path = "/tank/Apps/paperless/incoming";
              "read only" = "no";
            };
            Software = {
              path = "/tank/Software";
              "read only" = "no";
            };
            TimeMachineBackup = {
              path = "/tank/Backup/TimeMachine";
              "read only" = "no";
              "fruit:aapl" = "yes";
              "fruit:time machine" = "yes";
            };
          };
        };

        smartd.enable = true;
        smartctl-exporter.enable = true;
      };

      users = {
        additionalUsers = {
          manyie = {
            isNormalUser = true;
            extraGroups = ifGroupsExist [
              "samba-users"
            ];
          };
        };
        groups = {
          external-services = {
            gid = 65542;
          };
          admins = {
            gid = 991;
            members = [
              "bjw-s"
            ];
          };
        };
      };
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
