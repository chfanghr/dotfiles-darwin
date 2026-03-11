{
  inputs,
  lib,
  ...
}: let
  inherit (lib) nameValuePair listToAttrs;

  mkDarwinSystem = {
    system,
    hostname,
  }: let
    name = hostname;
    val = inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.home-manager.darwinModules.default
        inputs.determinate.darwinModules.default
        ../modules/nix-darwin
        {dotfiles.darwin = {inherit hostname;};}
        ./${hostname}
      ];
    };
  in
    nameValuePair name val;
in {
  flake.darwinConfigurations = listToAttrs [
    (mkDarwinSystem {
      system = "aarch64-darwin";
      hostname = "Dioscuri";
    })
    (mkDarwinSystem {
      system = "aarch64-darwin";
      hostname = "Hera";
    })
  ];
}
