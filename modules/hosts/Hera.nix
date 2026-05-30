{config, ...}: {
  configurations.darwin.Hera.module = {
    imports = [config.flake.modules.darwin.common];

    my.shared.inheritable = {
      machine = {
        hostname = "Hera";
        arch = "aarch64";
      };
      env.isDesktop = true;
    };
  };
}
