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
  options.my = {
    lib = mkOption {
      type = types.attrs;
      default = {};
    };
    shared = {
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
      inheritable = {
        machine = {
          arch = mkOption {
            type = types.enum [
              "aarch64"
              "x86_64"
            ];
          };
          hostname = mkOption {
            type = types.str;
          };
        };
        env = {
          isSlim = mkOption {
            type = types.bool;
            default = false;
          };
          isDesktop = mkOption {
            type = types.bool;
            default = false;
          };
          isGamingRig = mkOption {
            type = types.bool;
            default = false;
          };
        };
      };
    };
  };

  config.my = {
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
