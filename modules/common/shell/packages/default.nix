{pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.du-dust
    pkgs.findutils
    pkgs.gum
    pkgs.jo
    pkgs.jq
    pkgs.yq-go
    pkgs.wget
  ];
}
