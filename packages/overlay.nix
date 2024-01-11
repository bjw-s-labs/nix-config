{ inputs, system, ... }:
final: prev:
{
  kubecm = prev.kubecm.override {
    buildGoModule = args: prev.buildGoModule (args // {
      meta.mainProgram = "kubecm";
    });
  };
}
