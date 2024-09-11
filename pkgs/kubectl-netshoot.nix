{
  lib,
  fetchFromGitHub,
  buildGoModule,
  installShellFiles,
  ...
}:

buildGoModule rec {
  pname = "kubectl-netshoot";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nilic";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-6IQmD2tJ1qdjeJqOnHGSpfNg6rxDRmdW9a9Eon/EdsM=";
  };

  vendorHash = "sha256-x8Jvi+RX63wpyICI2GHqDTteV877evzfCxZDOnkBDWA=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    cat <<EOF >$out/bin/kubectl_complete-netshoot
    #!/usr/bin/env sh
    kubectl netshoot __complete "\$@"
    EOF
    chmod u+x $out/bin/kubectl_complete-netshoot
  '';

  meta = with lib; {
    description = "Kubernetes CLI plugin to spin up netshoot container for network troubleshooting";
    mainProgram = "kubectl-netshoot";
    homepage = "https://github.com/nilic/kubectl-netshoot";
    changelog = "https://github.com/nilic/kubectl-netshoot/releases/tag/v${version}";
  };
}
