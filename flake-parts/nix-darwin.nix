{
  inputs,
  self,
  flake-parts-lib,
  ...
}: let
  inherit (flake-parts-lib) importApply;
in {
  flake.darwinModules.common = importApply ../nix-darwin/common {
    inherit self inputs flake-parts-lib;
  };
}
