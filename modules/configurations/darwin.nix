{
  config,
  inputs,
  lib,
  ...
}: {
  options.configurations.darwin = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule {
      options.module = lib.mkOption {
        type = lib.types.deferredModule;
      };
    });
    default = {};
  };

  config.flake.darwinConfigurations = lib.flip lib.mapAttrs config.configurations.darwin (
    _: {module}:
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [module];
      }
  );
}
