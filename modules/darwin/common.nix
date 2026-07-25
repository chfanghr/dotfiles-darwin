{
  config,
  inputs,
  ...
}: let
  topConfig = config;
in {
  flake.modules.darwin.common = {config, ...}: let
    inherit (config.my.shared.inheritable.machine) arch hostname;
  in {
    imports = [
      inputs.home-manager.darwinModules.default
      inputs.determinate.darwinModules.default
      inputs.nix-index-database.darwinModules.nix-index
      topConfig.flake.modules.darwin.shared
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    system.stateVersion = 6;

    networking = {
      computerName = hostname;
      localHostName = hostname;
      hostName = hostname;
    };

    nixpkgs = {
      system = "${arch}-darwin";
      config.allowUnfree = true;
    };
  };
}
