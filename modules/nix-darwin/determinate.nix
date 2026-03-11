{
  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
    };
    determinateNixd = {
      garbageCollector.strategy = "automatic";
    };
  };
}
