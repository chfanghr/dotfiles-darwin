{
  lib,
  self,
  inputs,
  ...
}: let
  hosts = import ../hosts {inherit self inputs lib;};
in {
  flake.darwinConfigurations = hosts.darwin;
}
