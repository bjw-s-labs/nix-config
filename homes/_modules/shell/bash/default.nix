{
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  config = lib.mkIf isDarwin {
    programs.bash.enable = true;
  };
}
