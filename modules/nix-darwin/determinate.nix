{
  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
      substituters = ["https://microvm.cachix.org" "https://cache.iog.io"];
      trusted-public-keys = ["microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
    };
    determinateNixd = {
      garbageCollector.strategy = "automatic";
    };
    nixosVmBasedLinuxBuilder.enable = true;
  };
}
