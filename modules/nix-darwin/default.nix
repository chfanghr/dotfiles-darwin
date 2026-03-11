{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./determinate.nix
    ./homebrew.nix
    ./global.nix
    ./security.nix
    ./users
  ];

  options = {
    dotfiles.darwin.slim = mkEnableOption "only enable the bare minimum" // { default = false; };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = 6;
  };
}
