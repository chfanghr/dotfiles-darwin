{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit
    (lib)
    mkOption
    types
    mkMerge
    mkIf
    elem
    filter
    ;

  cfg = config.my.shared;
in {
  options.my.shared = {
    machine = {
      system = mkOption {
        type = types.str;
        default = pkgs.stdenv.hostPlatform.system;
        readOnly = true;
      };

      isDarwin = mkOption {
        type = types.bool;
        default = pkgs.stdenv.isDarwin;
        readOnly = true;
      };

      isLinux = mkOption {
        type = types.bool;
        default = pkgs.stdenv.isLinux;
        readOnly = true;
      };
    };

    lib = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config.my.shared = {
    lib = rec {
      mkIfElse = p: yes: no:
        mkMerge [
          (mkIf p yes)
          (mkIf (!p) no)
        ];

      isPackageSupported = pkg: elem cfg.machine.system pkg.meta.platforms;
      supportedPackagesOnly = filter isPackageSupported;
    };
  };
}
