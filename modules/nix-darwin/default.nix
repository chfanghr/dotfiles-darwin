{
  imports = [
    ./determinate.nix
    ./global.nix
    ./security.nix
    ./users
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;
}
