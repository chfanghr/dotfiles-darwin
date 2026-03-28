{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (config.dotfiles.darwin) hostname;
in {
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.determinate.darwinModules.default
    ./users
    ./defaults.nix
    ./determinate.nix
    ./doc.nix
    ./global.nix
    ./homebrew.nix
    ./keyboard.nix
    ./security.nix
    ./services.nix
  ];

  options = {
    dotfiles.darwin = {
      slim =
        mkEnableOption "only enable the bare minimum"
        // {
          default = false;
        };
      hostname = mkOption {type = types.str;};
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = 6;

    networking = {
      computerName = hostname;
      localHostName = hostname;
      hostName = hostname;
    };
  };
}
