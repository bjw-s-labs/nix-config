{
  pkgs,
  ...
}:
{
  config = {
    home.packages = [
      pkgs.doggo
    ];

    programs.fish = {
      shellAliases = {
        dig = "doggo";
      };
    };
  };
}
