{
  inputs,
  lib,
  self,
  ...
}: let
  inherit (lib) nameValuePair listToAttrs;

  mkDarwinSystem = {
    system,
    hostname,
  }: let
    name = hostname;
    val = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      inherit system;
      modules = [
        self.darwinModules.common
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
