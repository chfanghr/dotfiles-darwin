{
  self,
  inputs,
  flake-parts-lib,
  ...
}: {config, ...}: let
  inherit (flake-parts-lib) importApply;
  inherit (config.my.shared.inheritable.machine) hostname arch;
in {
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.determinate.darwinModules.default
    self.sharedModules.default
    (importApply ./users {
      inherit flake-parts-lib;
      inherit (self) homeModules;
    })
    ./defaults.nix
    ./doc.nix
    ./global.nix
    ./homebrew.nix
    ./keyboard.nix
    ./nix.nix
    ./security.nix
    ./services.nix
  ];

  config = {
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
