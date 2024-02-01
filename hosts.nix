let
  hasSuffix = suffix: content:
    let
      inherit (builtins) stringLength substring;
      lenContent = stringLength content;
      lenSuffix = stringLength suffix;
    in
    lenContent >= lenSuffix
    && substring (lenContent - lenSuffix) lenContent content == suffix
  ;

  mkHost =
    { type
    , hostPlatform
    , address ? null
    , pubkey ? null
    , homeDirectory ? null
    , remoteBuild ? true
    , large ? false
    }:
    if type == "nixos" then
      assert address != null && pubkey != null;
      assert (hasSuffix "linux" hostPlatform);
      {
        inherit type hostPlatform address pubkey remoteBuild large;
      }
    else if type == "darwin" then
      assert pubkey != null;
      assert (hasSuffix "darwin" hostPlatform);
      {
        inherit type hostPlatform pubkey large;
      }
    else if type == "home-manager" then
      assert homeDirectory != null;
      {
        inherit type hostPlatform homeDirectory large;
      }
    else throw "unknown host type '${type}'";
in
{
  bernd-macbook = mkHost {
    type = "darwin";
    hostPlatform = "aarch64-darwin";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRlfGCSK2w34ckIGoRHaZ01CbF/7Zk4VNmyokkvg7cF";
  };
  gladius = mkHost {
    type = "nixos";
    address = "gladius.bjw-s.casa";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTh+kYOeeYoBuxvA00nGojfBHUQlXW3iF7aRIw9VbY1";
    remoteBuild = true;
  };
}
