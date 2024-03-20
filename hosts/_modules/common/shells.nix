{
  pkgs,
  ...
}:
{
  environment.shells = with pkgs; [fish];

  programs = {
    fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };
}
