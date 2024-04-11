_:
{
  config = {
    programs.btop = {
      enable = true;
      catppuccin.enable = true;
    };

    programs.fish = {
      shellAliases = {
        top = "btop";
      };
    };
  };
}
