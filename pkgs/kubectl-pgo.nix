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
  vendorHash = "sha256-r7/McIXQW3dwXZko+RSeA3ewAyxgTVa1cMja5fqPIP0=";

  doCheck = false;

  meta = {
    description = "Kubernetes CLI plugin to manage Crunchy PostgreSQL Operator resources.";
    mainProgram = "kubectl-pgo";
    homepage = "https://github.com/CrunchyData/postgres-operator-client";
    changelog = "https://github.com/CrunchyData/postgres-operator-client/releases/tag/v${version}";
  };
}
