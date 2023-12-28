{pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.findutils
    pkgs.jo
    pkgs.jq
    pkgs.yq-go
    pkgs.wget
  ];
}
