{
  inputs,
  lib,
  ...
}: let
  inherit (lib) nameValuePair listToAttrs;

  mkDarwinSystem = {
    system,
    hostname,
    modules ? [],
  }: let
    name = hostname;
    val = inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules =
        [
          inputs.home-manager.darwinModules.default
          inputs.determinate.darwinModules.default
          ../modules/nix-darwin
          {dotfiles.darwin = {inherit hostname;};}
        ]
        ++ modules;
    };
  in
    nameValuePair name val;
in {
  flake.darwinConfigurations = listToAttrs [
    (mkDarwinSystem {
      system = "aarch64-darwin";
      hostname = "Dioscuri";
      modules = [./Dioscuri];
    })
    # TODO: Hera
  ];
}
