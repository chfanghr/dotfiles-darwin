{
  self,
  inputs,
  flake-parts-lib,
  ...
}: let
  inherit (flake-parts-lib) importApply;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    self.sharedModules.default
    ./gpg
    ./java.nix
    ./packages.nix
    (importApply ./shell.nix {inherit (self) nvfModules;})
    ./ssh.nix
    ./terminal.nix
    ./version-control.nix
  ];

  home.stateVersion = "24.11";
}
