{
  pkgs,
  lib,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.kubectl-klock;
in
pkgs.buildGoModule rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-xz1I79FklKNpWdoQdzpXYAnKM+7FJcGn04lKH2E9A50=";

  doCheck = false;

  postInstall = ''
    cat <<EOF >$out/bin/kubectl_complete-klock
    #!/usr/bin/env sh
    kubectl klock __complete "\$@"
    EOF
    chmod u+x $out/bin/kubectl_complete-klock
  '';

  meta = {
    description = "A kubectl plugin to render watch output in a more readable fashion";
    mainProgram = "kubectl-klock";
    homepage = "https://github.com/applejag/kubectl-klock";
    changelog = "https://github.com/applejag/kubectl-klock/releases/tag/v${version}";
  };
}
