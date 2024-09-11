{
  lib,
  fetchFromGitHub,
  buildGoModule,
  installShellFiles,
  ...
}:

buildGoModule rec {
  pname = "kubectl-get-all";
  version = "1.3.8";

  src = fetchFromGitHub {
    owner = "timebertt";
    repo = "ketall";
    rev = "upgrade-dependencies";
    hash = "sha256-qyyKnN7lY0zU8XUe+El2XIkGJ0bP4FoIfpjtKUfgfLU=";
  };

  vendorHash = "sha256-VgT42lIlNJw6OT23CuHLEh7PRgyCfmwkuWwIQpNqBfo=";

  nativeBuildInputs = [ installShellFiles ];

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

  meta = with lib; {
    description = "Kubernetes CLI plugin to really get all resources";
    mainProgram = "kubectl-get-all";
    homepage = "https://github.com/corneliusweig/ketall";
    changelog = "https://github.com/corneliusweig/ketall/releases/tag/v${version}";
  };
}
