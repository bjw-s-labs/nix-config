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
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.usage-cli;
in
rustPlatform.buildRustPackage rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  cargoHash = "sha256-gEZOphc3imOR01MpduUn5+s8gbmNr0yjXarKGfVk/1c=";

  buildInputs = lib.optionals isDarwin [ Security SystemConfiguration ];

  meta = {
    homepage = "https://usage.jdx.dev";
    description = "A specification for CLIs";
    changelog = "https://github.com/jdx/usage/releases/tag/v${version}";
    mainProgram = "usage";
  };
}
