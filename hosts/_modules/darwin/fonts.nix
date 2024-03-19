{
  pkgs,
  ...
}:
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      monaspace
    ];
  };
}
