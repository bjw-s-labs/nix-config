{
  lib,
  fetchFromGitHub,
  buildGoModule,
  ...
}:

buildGoModule rec {
  pname = "shcopy";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "aymanbagabas";
    repo = "shcopy";
    rev = "v${version}";
    hash = "sha256-lEYMBBtBGAJjU0F1HgvuH0inW6S5E9DyKxwQ6A9tdM4=";
  };

  vendorHash = "sha256-kD73EozkeUd23pwuy71bcNmth2lEKom0CUPDUNPNB1Q=";

  meta = {
    homepage = "https://github.com/aymanbagabas/shcopy";
    description = "Copy text to your system clipboard locally and remotely using ANSI OSC52 sequence";
    changelog = "https://github.com/aymanbagabas/shcopy/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bjw-s ];
    mainProgram = "shcopy";
  };
}
