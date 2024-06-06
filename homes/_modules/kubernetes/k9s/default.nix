{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.kubernetes;
  themeConfig = config.modules.themes;

in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.k9s = {
        enable = true;
        package = pkgs.unstable.k9s;
        catppuccin.enable = true;

        aliases = {
          aliases = {
            dp = "deployments";
            sec = "v1/secrets";
            jo = "jobs";
            cr = "clusterroles";
            crb = "clusterrolebindings";
            ro = "roles";
            rb = "rolebindings";
            np = "networkpolicies";
          };
        };

        settings = {
          k9s = {
            liveViewAutoRefresh = false;
            refreshRate = 2;
            maxConnRetry = 5;
            readOnly = false;
            noExitOnCtrlC = false;
            ui = {
              enableMouse = false;
              headless = false;
              logoless = false;
              crumbsless = false;
              reactive = false;
              noIcons = false;
            };
            skipLatestRevCheck = false;
            disablePodCounting = false;
            shellPod = {
              image = "busybox";
              namespace = "default";
              limits = {
                cpu = "100m";
                memory = "100Mi";
              };
            };
            imageScans = {
              enable = false;
              exclusions = {
                namespaces = [];
                labels = {};
              };
            };
            logger = {
              tail = 100;
              buffer = 5000;
              sinceSeconds = -1;
              fullScreen = false;
              textWrap = false;
              showTime = false;
            };
            thresholds = {
              cpu = {
                critical = 90;
                warn = 70;
              };
              memory = {
                critical = 90;
                warn = 70;
              };
            };
          };
        };
      };
    })
  ];
}
