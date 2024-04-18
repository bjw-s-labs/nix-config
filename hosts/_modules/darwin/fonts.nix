{
  pkgs,
  ...
}:
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code-nerdfont
      font-awesome
      monaspace
    ];
  };
}
