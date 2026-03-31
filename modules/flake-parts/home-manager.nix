{
  inputs,
  self,
  ...
}: {
  flake.homeModules.fanghr = {
    imports = [../home-manager/fanghr];
    _module.args = {
      inherit inputs;
      inherit (self) nvfModules;
    };
  };
}
