{
  config,
  inputs,
  ...
}: let
  topConfig = config;
in {
  flake.modules.homeManager.fanghr = {
    imports = [
      inputs.nvf.homeManagerModules.default
      topConfig.flake.modules.homeManager.shared
    ];

    home.stateVersion = "24.11";
  };
}
