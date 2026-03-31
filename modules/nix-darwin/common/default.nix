{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (config.dotfiles.darwin) hostname arch;
in {
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.determinate.darwinModules.default
    ./users
    ./defaults.nix
    ./doc.nix
    ./global.nix
    ./homebrew.nix
    ./keyboard.nix
    ./nix.nix
    ./security.nix
    ./services.nix
  ];

  options = {
    dotfiles.darwin = {
      hostname = mkOption {type = types.str;};
      arch = mkOption {
        type = types.enum [
          "aarch64"
          "x86_64"
        ];
      };
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
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
