{
  homeModules,
  flake-parts-lib,
  ...
}: let
  inherit (flake-parts-lib) importApply;
in {
  imports = [(importApply ./fanghr.nix {inherit homeModules;})];

  system.primaryUser = "fanghr";
}
