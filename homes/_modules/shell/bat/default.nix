{
  pkgs,
  ...
}:
{
  config = {
    programs.bat = {
      enable = true;
      catppuccin.enable = true;
    };

    programs.fish = {
      shellAliases = {
        cat = "bat";
      };
    };
  };
}
