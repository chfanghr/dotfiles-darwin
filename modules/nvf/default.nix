{
  inputs,
  self,
  ...
}: {
  flake.nvfModules.common = import ./common;

  perSystem = {pkgs, ...}: {
    packages.nvim-common =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [self.nvfModules.common];
      }).neovim;
  };
}
