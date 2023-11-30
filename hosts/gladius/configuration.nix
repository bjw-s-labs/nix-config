{ ... }:

{
  config = {
    modules = {
      device = {
        cpu = "intel";
        gpu = "intel";
        hostId = "775b7d55";
      };

      users.bjw-s.enable = true;
      users.groups = {
        external-services = {
          gid = 65542;
        };
        admins = {
          gid = 991;
          members = ["bjw-s"];
        };
      };

      filesystem.zfs.enable = true;
      filesystem.zfs.mountPoolsAtBoot = [
        "tank"
      ];

      monitoring.smartd.enable = true;

      servers.k3s.enable = true;
      servers.nfs.enable = true;
      servers.samba.enable = true;
      servers.samba.shares = {
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
          "vfs objects" = "acl_xattr catia fruit streams_xattr";
          "fruit:time machine" = "yes";
          "comment" = "Time Machine Backups";
          "path" = "/tank/Backup/TimeMachine";
          "read only" = "no";
        };
      };

      system.openssh.enable = true;
      system.video.enable = true;
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
