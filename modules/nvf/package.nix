{
  config,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.nvim-common =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [config.flake.modules.nvf.common];
      }).neovim;
  };
}
