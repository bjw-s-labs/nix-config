{
  pkgs,
  lib,
  buildGoModule,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.kubectl-klock;
in
buildGoModule rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-lhawUcjB2EULpAFjBM4tdmDo08za2DfyZUvEPo4+LXE=";

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
