_:
{
  config = {
    programs.eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group"
      ];
      enableAliases = true;
    };
  };
}
