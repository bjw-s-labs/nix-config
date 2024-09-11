{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.kubernetes;
in
{
  options.modules.kubernetes = {
    enable = lib.mkEnableOption "kubernetes";
  };

  config = lib.mkIf cfg.enable {
    home.packages = (with pkgs; [
      kubectl-browse-pvc
      kubectl-get-all
      kubectl-netshoot
      talhelper
    ]) ++
    (with pkgs.unstable; [
      fluxcd
      helmfile
      krew
      kubecm
      kubeconform
      kubectl
      kubectl-neat
      kubectl-node-shell
      kubectl-view-secret
      kubernetes-helm
      stern
      talosctl
    ]);

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

    programs.fish = {
      interactiveShellInit = ''
        fish_add_path $HOME/.krew/bin
        ${lib.getExe pkgs.unstable.kubecm} completion fish | source
      '';

      functions = {
        kyaml = {
          description = "Clean up kubectl get yaml output";
          body = ''
            kubectl get $argv -o yaml | kubectl-neat
          '';
        };
      };
      shellAliases = {
        k = "kubectl";
        kc = "kubecm";
      };
    };
  };
}
