{
  inputs,
  ...
}:
{
  rust-overlay = inputs.rust-overlay.overlays.default;

  additions = final: prev: {
    # flake = import ../pkgs {
    #   pkgs = prev;
    #   inherit inputs;
    # };
  };

  modifications = final: prev: {
    # kubecm = prev.kubecm.overrideAttrs (_: prev: {
    #   meta = prev.meta // {
    #     mainProgram = "kubecm";
    #   };
    # });
  };

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
