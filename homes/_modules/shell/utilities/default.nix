{ pkgs, flake-packages, ... }: {
  config = {
    home.packages = with pkgs;
      with flake-packages.${pkgs.system}; [
        any-nix-shell
        binutils
        coreutils
        curl
        du-dust
        envsubst
        findutils
        fish
        gawk
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
