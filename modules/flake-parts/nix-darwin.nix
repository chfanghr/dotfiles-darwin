{
  inputs,
  self,
  ...
}: {
  flake.darwinModules.common = {
    _module.args = {
      inherit inputs;
      inherit (self) homeModules;
    };

    imports = [
      self.sharedModules.default
      ../nix-darwin/common
    ];
  };
}
