{ lib
, nix-update-script
, rustPlatform
, fetchFromGitHub
, installShellFiles
, stdenv
, coreutils
, bash
, pkg-config
, openssl
, direnv
, pkgs
}:

rustPlatform.buildRustPackage rec {
  pname = "mise";
  version = "2024.1.21";

  src = fetchFromGitHub {
    owner = "jdx";
    repo = "mise";
    rev = "v${version}";
    hash = "sha256-y/6v5l4TYHglo5auyvmVLZPYFackvLB3pSBxmRpEZhU=";
  };

  cargoHash = "sha256-OPjitICAIlqJTm7LDn4zmFx1o8F/HXasdD5noiK8Yis=";

  nativeBuildInputs = [ installShellFiles pkg-config ];
  buildInputs = [ openssl  ] ++ lib.optionals stdenv.isDarwin [ pkgs.darwin.apple_sdk.frameworks.Security pkgs.darwin.apple_sdk.frameworks.SystemConfiguration ];

  postPatch = ''
    patchShebangs --build ./test/data/plugins/**/bin/* ./src/fake_asdf.rs ./src/cli/reshim.rs

    substituteInPlace ./src/env_diff.rs \
      --replace '"bash"' '"${bash}/bin/bash"'

    substituteInPlace ./src/cli/direnv/exec.rs \
      --replace '"env"' '"${coreutils}/bin/env"' \
      --replace 'cmd!("direnv"' 'cmd!("${direnv}/bin/direnv"'
  '';

  checkFlags = [
    # Requires .git directory to be present
    "--skip=cli::plugins::ls::tests::test_plugin_list_urls"
  ];
  cargoTestFlags = [ "--all-features" ];
  # some tests access the same folders, don't test in parallel to avoid race conditions
  dontUseCargoParallelTests = true;

  postInstall = ''
    installManPage ./man/man1/mise.1

    installShellCompletion \
      --bash ./completions/mise.bash \
      --fish ./completions/mise.fish \
      --zsh ./completions/_mise
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    homepage = "https://github.com/jdx/mise";
    description = "dev tools, env vars, task runner";
    changelog = "https://github.com/jdx/mise/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "mise";
  };
}
