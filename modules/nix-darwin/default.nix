{lib, ...}: let
  inherit (lib) mkEnableOption;
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
    dotfiles.darwin.slim = mkEnableOption "only enable the bare minimum" // {default = false;};
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
