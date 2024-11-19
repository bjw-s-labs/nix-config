_:
{
  config = {
    programs.eza = {
      enable = true;
      icons = "auto";
      extraOptions = [
        "--group"
      ];
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
