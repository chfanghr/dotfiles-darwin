{inputs, ...}: {
  flake.homeModules.fanghr = {
    imports = [./fanghr];
    _module.args = {inherit inputs;};
  };
}
