{
  pkgs,
  lib,
  buildGoModule,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packagedata = sourceData.kubectl-get-all;
in
buildGoModule rec {
  inherit (packagedata) pname src;
  version = lib.strings.removePrefix "v" packagedata.version;
  vendorHash = "sha256-lxfWJ7t/IVhIfvDUIESakkL8idh+Q/wl8B1+vTpb5a4=";

  doCheck = false;

  tags = [
    "getall"
    "netgo"
  ];

  postInstall = ''
    mv $out/bin/ketall $out/bin/kubectl-get_all

    cat <<EOF >$out/bin/kubectl_complete-get_all
    #!/usr/bin/env sh
    kubectl get-all __complete "\$@"
    EOF
    chmod u+x $out/bin/kubectl_complete-get_all
  '';

  meta = {
    description = "Kubernetes CLI plugin to really get all resources";
    mainProgram = "kubectl-get-all";
    homepage = "https://github.com/corneliusweig/ketall";
    changelog = "https://github.com/corneliusweig/ketall/releases/tag/v${version}";
  };
}
