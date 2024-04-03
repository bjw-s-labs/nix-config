_:
{
  config = {
    programs.btop = {
      enable = true;
    };

    programs.fish = {
      shellAliases = {
        top = "btop";
      };
    };
  };
}
