{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.development;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cue
      nixd
      nixfmt-rfc-style
      nodePackages.prettier
      pre-commit
      shellcheck
      shfmt
      yamllint
      unstable.helm-ls
      unstable.minio-client
      inputs.nix-inspect.packages.${pkgs.system}.default
    ];
  };
}
