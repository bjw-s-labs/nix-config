{
  pkgs,
  ...
}:
{
  config = {
    programs.zoxide = {
      enable = true;
    };

    programs.fish = {
      plugins = [
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
    };
  };
}
