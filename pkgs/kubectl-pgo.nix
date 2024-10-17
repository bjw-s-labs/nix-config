{
  pkgs,
  lib,
  buildGoModule,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.kubectl-pgo;
in
buildGoModule rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-PhTDqsFhPas2mcK7Ew2TQNqnvftk/+7wo2yFE9dnSUY=";

  doCheck = false;

  meta = {
    description = "Kubernetes CLI plugin to manage Crunchy PostgreSQL Operator resources.";
    mainProgram = "kubectl-pgo";
    homepage = "https://github.com/CrunchyData/postgres-operator-client";
    changelog = "https://github.com/CrunchyData/postgres-operator-client/releases/tag/v${version}";
  };
}
