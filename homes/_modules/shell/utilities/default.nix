{
  pkgs,
  ...
}:
{
  config = {
    home.packages = with pkgs; [
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
      tmux
      vim
      wget
      yq-go
    ];
  };
}
