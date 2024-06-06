_:
{
  config = {
    programs.eza = {
      enable = true;
      icons = true;
      extraOptions = [
        "--group"
      ];
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
