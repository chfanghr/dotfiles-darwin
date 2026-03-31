{
  inputs,
  lib,
  self,
  ...
}: let
  inherit (lib) nameValuePair listToAttrs;

  mkDarwinSystem = {hostname, ...}: let
    name = hostname;
    val = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        self.darwinModules.common
        ./${hostname}
      ];
    };
  in
    nameValuePair name val;
in {
  flake.darwinConfigurations = listToAttrs [
    (mkDarwinSystem {hostname = "Dioscuri";})
    (mkDarwinSystem {hostname = "Hera";})
    (mkDarwinSystem {hostname = "Granicus";})
  ];
}
