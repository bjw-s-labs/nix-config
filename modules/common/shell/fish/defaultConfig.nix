{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    icons = true;
    enableAliases = true;
  };
  programs.zoxide.enable = true;
  programs.fish = {
    enable = true;
    plugins = [
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
      {
        name = "zoxide";
        src = pkgs.fetchFromGitHub {
          owner = "kidonng";
          repo = "zoxide.fish";
          rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
          sha256 = "Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
        };
      }
    ];

    shellAliases = {
      # other
      df = "df -h";
      du = "du -h";
    };

    functions = {
      fish_greeting = {
        description = "Set the fish greeting";
        body = builtins.readFile ./functions/fish_greeting.fish;
      };
    };
  };
}
