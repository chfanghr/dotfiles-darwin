{config, ...}: {
  configurations.darwin.Granicus.module = {
    imports = [config.flake.modules.darwin.common];

    my.shared.inheritable = {
      machine = {
        hostname = "Granicus";
        arch = "x86_64";
      };
      env.isSlim = true;
    };

    ids.gids.nixbld = 30000;
  };
}
