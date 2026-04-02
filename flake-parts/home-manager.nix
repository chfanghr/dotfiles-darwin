{
  flake-parts-lib,
  self,
  inputs,
  ...
}: let
  inherit (flake-parts-lib) importApply;
in {
  flake.homeModules.fanghr = importApply ../home-manager/fanghr {
    inherit self inputs flake-parts-lib;
  };
}
