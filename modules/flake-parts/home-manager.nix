{
  inputs,
  self,
  ...
}: {
  flake.homeModules.fanghr = {
    imports = [
      ../home-manager/fanghr
      self.sharedModules.default
    ];
    _module.args = {
      inherit inputs;
      inherit (self) nvfModules;
    };
  };
}
