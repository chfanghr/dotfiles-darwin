{
  config,
  lib,
  ...
}: let
  substituters = [
    "https://microvm.cachix.org"
    "https://cache.iog.io"
  ];
  trusted-public-keys = [
    "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  inherit (lib) mkOverride mkMerge mkIf;
  mkIfElse = p: yes: no:
    mkMerge [
      (mkIf p yes)
      (mkIf (!p) no)
    ];
in
  # NOTE: determinate nix only support apple silicon
  mkIfElse (config.my.shared.inheritable.machine.arch == "aarch64")
  {
    determinateNix = {
      enable = true;
      customSettings = {
        eval-cores = 0;
        inherit substituters trusted-public-keys;
      };
      determinateNixd = {
        garbageCollector.strategy = "automatic";
      };
      nixosVmBasedLinuxBuilder.enable = true;
    };
  }
  {
    nix = {
      enable = mkOverride 10 true;
      gc.automatic = true;
    };
  }
