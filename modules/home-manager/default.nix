{
  inputs,
  self,
  ...
}: {
  flake.homeModules.fanghr = {
    imports = [./fanghr];
    _module.args = {
      inherit inputs;
      inherit (self) nvfModules;
    };
  };
}
