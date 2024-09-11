{
  inputs,
  ...
}:
{
  rust-overlay = inputs.rust-overlay.overlays.default;

  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through `pkgs.unstable`
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        # overlays of unstable packages are declared here
        (final: prev: {
          kubectl-node-shell = prev.kubectl-node-shell.overrideAttrs (_: prev: {
            meta = builtins.removeAttrs prev.meta ["platforms"];
          });
          kubectl-view-secret = prev.kubectl-view-secret.overrideAttrs (_: prev: {
            postInstall = ''
              mv $out/bin/cmd $out/bin/kubectl-view_secret
            '';
          });
        })
      ];
    };
  };

  # Your own overlays for stable nixpkgs should be declared here
  nixpkgs-overlays = final: prev: {
    # kubectl-view-secret = prev.kubectl-view-secret.overrideAttrs (_: prev: {
    #   postInstall = ''
    #     mv $out/bin/cmd $out/bin/kubectl-view_secret
    #   '';
    # });
  };
}
