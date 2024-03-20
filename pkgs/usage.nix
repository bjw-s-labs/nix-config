{
  pkgs,
  lib,
  fetchFromGitHub,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (pkgs.darwin.apple_sdk.frameworks) Security SystemConfiguration;
  rustPlatform = pkgs.makeRustPlatform {
    cargo = pkgs.rust-bin.stable.latest.minimal;
    rustc = pkgs.rust-bin.stable.latest.minimal;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "usage-cli";
  version = "0.1.17";

  src = fetchFromGitHub {
    owner = "jdx";
    repo = "usage";
    rev = "v${version}";
    hash = "sha256-xcuP0RIlZulvuv5aVtoHod8lm/6lK+kNABU5BtWyxfc=";
  };

  cargoHash = "sha256-VgrYhJU0pClEr2MJXk4IxJWL7PVG8YHAb8ITo9wBMPw=";

  buildInputs = [ ] ++ lib.optionals isDarwin [ Security SystemConfiguration ];

  meta = {
    homepage = "https://usage.jdx.dev";
    description = "A specification for CLIs";
    changelog = "https://github.com/jdx/usage/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bjw-s ];
    mainProgram = "usage";
  };
}
