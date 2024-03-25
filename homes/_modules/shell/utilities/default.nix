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
