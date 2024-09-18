{
  pkgs,
  lib,
  buildGoModule,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.kubectl-netshoot;
in
buildGoModule rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-x8Jvi+RX63wpyICI2GHqDTteV877evzfCxZDOnkBDWA=";

  doCheck = false;

  postInstall = ''
    cat <<EOF >$out/bin/kubectl_complete-netshoot
    #!/usr/bin/env sh
    kubectl netshoot __complete "\$@"
    EOF
    chmod u+x $out/bin/kubectl_complete-netshoot
  '';

  meta = {
    description = "Kubernetes CLI plugin to spin up netshoot container for network troubleshooting";
    mainProgram = "kubectl-netshoot";
    homepage = "https://github.com/nilic/kubectl-netshoot";
    changelog = "https://github.com/nilic/kubectl-netshoot/releases/tag/v${version}";
  };
}
