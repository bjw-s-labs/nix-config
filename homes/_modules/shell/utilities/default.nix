{
  pkgs,
  flake-packages,
  ...
}:
{
  config = {
    home.packages = with pkgs; with flake-packages.${pkgs.system}; [
      binutils
      coreutils
      curl
      du-dust
      envsubst
      findutils
      fish
      gnused
      gum
      jo
      jq
      shcopy
      tmux
      vim
      wget
      yq-go
    ];
  };
}
