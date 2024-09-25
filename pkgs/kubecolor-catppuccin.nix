{
  pkgs,
  stdenv,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.kubecolor-catppuccin;
in
stdenv.mkDerivation {
  inherit (packageData) pname src version;

  installPhase = ''
    mkdir -p $out
    cp *.yaml $out
  '';
}
