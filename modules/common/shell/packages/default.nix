{pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.jq
    pkgs.yq
    pkgs.wget
  ];
}
