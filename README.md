# nix-config

[![built with nix](https://img.shields.io/badge/built_with_nix-blue?style=for-the-badge&logo=nixos&logoColor=white)](https://builtwithnix.org)

This repository holds my NixOS configuration. It is fully reproducible and flakes based.

Deployment is done using [deploy-rs] and [nix-darwin], see [usage](#usage).
Unfortunately [deploy-rs] does not yet support deploying to a local machine without the use of SSH. Therefore for Darwin machines I rely on the `darwin-rebuild` command from [nix-darwin].

For adding overlays see [overlays](#Adding-overlays).

## Usage

### Deploying

#### NixOS

Apply NixOS configuration to a node:

```console
$ task nix:deploy-nixos host=gladius
```

#### Darwin

Apply a Darwin configuration to the local machine:

```console
$ task nix:apply-darwin host=bernd-macbook
```

### Adding overlays

Overlays should be added as individual nix files to `./overlays` with format

```nix
final: prev: {
    hello = (prev.hello.overrideAttrs (oldAttrs: { doCheck = false; }));
}
```

For more examples see [./overlays](overlays).

[deploy-rs]: https://github.com/serokell/deploy-rs
[nix-darwin]: https://github.com/LnL7/nix-darwin
