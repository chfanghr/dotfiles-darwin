{
  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
      trusted-substituters = ["https://microvm.cachix.org"];
      trusted-public-keys = ["microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="];
    };
    determinateNixd = {
      garbageCollector.strategy = "automatic";
    };
  };
}
