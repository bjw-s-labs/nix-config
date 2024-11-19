{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration;
  rustPlatform = pkgs.makeRustPlatform {
    cargo = pkgs.rust-bin.stable.latest.minimal;
    rustc = pkgs.rust-bin.stable.latest.minimal;
  };
  sourceData = pkgs.callPackage ../_sources/generated.nix { };
  vendorHash = lib.importJSON ../_sources/vendorhash.json;
  packageData = sourceData.usage-cli;
in
rustPlatform.buildRustPackage rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  cargoHash = vendorHash.usage;

  buildInputs = lib.optionals isDarwin [ Security SystemConfiguration ];

  doCheck = false; # no tests

  meta = {
    homepage = "https://usage.jdx.dev";
    description = "A specification for CLIs";
    changelog = "https://github.com/jdx/usage/releases/tag/v${version}";
    mainProgram = "usage";
  };
}
