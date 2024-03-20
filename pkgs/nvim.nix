{
  pkgs,
  inputs,
  ...
}:

inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
  inherit pkgs;
  extraSpecialArgs = {};
  module = {
    imports = [ ../homes/bjw-s/config/editor/nvim ];
  };
}
