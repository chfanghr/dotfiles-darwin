{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.dotfiles.darwin) slim;
in
  mkIf (!slim) {
    documentation.man.enable = true;
  }
