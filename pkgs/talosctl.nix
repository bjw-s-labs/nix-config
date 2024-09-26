{
  pkgs,
  lib,
  installShellFiles,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.talosctl;
in
pkgs.unstable.buildGo123Module {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-9qkealjjdBO659fdWdgFii3ThPRwKpYasB03L3Bktqs=";

  ldflags = ["-s" "-w"];

  # This is needed to deal with workspace issues during the build
  overrideModAttrs = _: {
    GOWORK = "off";
  };
  GOWORK = "off";

  subPackages = ["cmd/talosctl"];

  nativeBuildInputs = [installShellFiles];

  postInstall = ''
    installShellCompletion --cmd talosctl \
      --bash <($out/bin/talosctl completion bash) \
      --fish <($out/bin/talosctl completion fish) \
      --zsh <($out/bin/talosctl completion zsh)
  '';

  doCheck = false; # no tests

  meta = with lib; {
    description = "A CLI for out-of-band management of Kubernetes nodes created by Talos";
    homepage = "https://www.talos.dev/";
    license = licenses.mpl20;
    mainProgram = "talosctl";
    maintainers = with maintainers; [flokli];
  };
}
