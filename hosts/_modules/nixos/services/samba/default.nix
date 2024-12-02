{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.services.samba;
in
{
  options.modules.services.samba = {
    enable = lib.mkEnableOption "samba";
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.samba-users = {};

    services.samba = {
      enable = true;
      package = pkgs.samba;
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "min protocol" = "SMB2";

          "ea support" = "yes";
          "vfs objects" = "acl_xattr catia fruit streams_xattr";
          "fruit:metadata" = "stream";
          "fruit:model" = "MacSamba";
          "fruit:veto_appledouble" = "no";
          "fruit:posix_rename" = "yes";
          "fruit:zero_file_id" = "yes";
          "fruit:wipe_intentionally_left_blank_rfork" = "yes";
          "fruit:delete_empty_adfiles" = "yes";
          "fruit:nfs_aces" = "no";

          "browseable" = "yes";
          "guest ok" = "no";
          "guest account" = "nobody";
          "map to guest" = "bad user";
          "inherit acls" = "yes";
          "map acl inherit" = "yes";
          "valid users" = "@samba-users";

          "veto files" = "/._*/.DS_Store/";
          "delete veto files" = "yes";
        };
      } // cfg.settings;
    };
  };
}
