{
  lib,
  ...
}:
{
  imports = [
    ./utilities
  ];

  options.modules.development = {
    enable = lib.mkEnableOption "development";
  };
}
