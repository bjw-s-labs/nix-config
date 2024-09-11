{
  lib,
  fetchFromGitHub,
  buildGoModule,
  ...
}:

buildGoModule rec {
  pname = "kubectl-browse-pvc";
  version = "1.0.7";

  src = fetchFromGitHub {
    owner = "clbx";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Ql+mMgpmcbGy5TwQrv8f9uWK9yNXfHykNDnOrp4E7+I=";
  };

  vendorHash = "sha256-kalnhBWVZaStdUeTiKln0mVow4x1K2+BZPXG+5/YRVM=";

  doCheck = false;

  postInstall = ''
    mv $out/bin/kubectl-browse-pvc $out/bin/kubectl-browse_pvc
  '';

  meta = with lib; {
    description = "Kubernetes CLI plugin for browsing PVCs on the command line";
    mainProgram = "kubectl-browse-pvc";
    homepage = "https://github.com/clbx/kubectl-browse-pvc";
    changelog = "https://github.com/clbx/kubectl-browse-pvc/releases/tag/v${version}";
  };
}
