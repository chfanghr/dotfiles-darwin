{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (config.dotfiles.darwin) hostname;
in {
  imports = [
    ./users
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
