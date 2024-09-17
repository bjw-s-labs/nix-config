{
  lib,
  fetchFromGitHub,
  buildGoModule,
  ...
}:

buildGoModule rec {
  pname = "kubectl-klock";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "applejag";
    repo = "kubectl-klock";
    rev = "v${version}";
    hash = "sha256-MmsHxB15gCz2W2QLC6E7Ao+9iLyVaYJatUgPcMuL79M=";
  };

  vendorHash = "sha256-lhawUcjB2EULpAFjBM4tdmDo08za2DfyZUvEPo4+LXE=";

  doCheck = false;

  postInstall = ''
    cat <<EOF >$out/bin/kubectl_complete-klock
    #!/usr/bin/env sh
    kubectl klock __complete "\$@"
    EOF
    chmod u+x $out/bin/kubectl_complete-klock
  '';

  meta = with lib; {
    description = "A kubectl plugin to render watch output in a more readable fashion";
    mainProgram = "kubectl-klock";
    homepage = "https://github.com/applejag/kubectl-klock";
    changelog = "https://github.com/applejag/kubectl-klock/releases/tag/v${version}";
  };
}
