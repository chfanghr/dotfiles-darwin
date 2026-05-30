{config, ...}: {
  configurations.darwin.Dioscuri.module = {
    imports = [config.flake.modules.darwin.common];

    my.shared.inheritable = {
      machine = {
        hostname = "Dioscuri";
        arch = "aarch64";
      };
      env = {
        isDesktop = true;
        isGamingRig = true;
      };
    };
  };
}
