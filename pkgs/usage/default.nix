{
  pkgs,
  lib,
  rustPlatform,
  nix-update-script,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration;

  sourceData = pkgs.callPackage ../_sources/generated.nix { };
  vendorHash = lib.importJSON ../_sources/vendorhash.json;
  packageData = sourceData.usage;
in
rustPlatform.buildRustPackage rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  cargoHash = vendorHash.usage;

  passthru = {
    updateScript = nix-update-script { };
  };

  doCheck = false; # no tests

  meta = {
    homepage = "https://usage.jdx.dev";
    description = "A specification for CLIs";
    changelog = "https://github.com/jdx/usage/releases/tag/v${version}";
    mainProgram = "usage";
  };
}
