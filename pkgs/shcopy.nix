{
  pkgs,
  lib,
  buildGoModule,
  ...
}:
let
  sourceData = pkgs.callPackage ./_sources/generated.nix { };
  packageData = sourceData.shcopy;
in
buildGoModule rec {
  inherit (packageData) pname src;
  version = lib.strings.removePrefix "v" packageData.version;
  vendorHash = "sha256-kD73EozkeUd23pwuy71bcNmth2lEKom0CUPDUNPNB1Q=";

  meta = {
    homepage = "https://github.com/aymanbagabas/shcopy";
    description = "Copy text to your system clipboard locally and remotely using ANSI OSC52 sequence";
    changelog = "https://github.com/aymanbagabas/shcopy/releases/tag/v${version}";
    mainProgram = "shcopy";
  };
}
