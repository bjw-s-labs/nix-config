{
  lib,
  fetchFromGitHub,
  buildGoModule,
  ...
}:

buildGoModule rec {
  pname = "kubectl-pgo";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "CrunchyData";
    repo = "postgres-operator-client";
    rev = "v${version}";
    # nix-shell -p nix-prefetch-github --run "nix-prefetch-github CrunchyData postgres-operator-client --rev v0.4.2"
    hash = "sha256-m1USG4Po+H9trrx4+Zw8SDCpXecEipawdwCYBLsuxd8=";
  };

  vendorHash = "sha256-r7/McIXQW3dwXZko+RSeA3ewAyxgTVa1cMja5fqPIP0=";
  doCheck = false;

  meta = with lib; {
    description = "Kubernetes CLI plugin to manage Crunchy PostgreSQL Operator resources.";
    mainProgram = "kubectl-pgo";
    homepage = "https://github.com/CrunchyData/postgres-operator-client";
    changelog = "https://github.com/CrunchyData/postgres-operator-client/releases/tag/v${version}";
  };
}
