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
        k3s = {
          enable = true;
          package = pkgs.unstable.k3s_1_29;
          extraFlags = [
            "--tls-san=${config.networking.hostName}.bjw-s.casa"
            "--tls-san=nas.k8s.bjw-s.casa"
          ];
        };

        nfs.enable = true;

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
      };

      users = {
        additionalUsers = {
          manyie = {
            isNormalUser = true;
            extraGroups = [
            ] ++ ifGroupsExist [
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
