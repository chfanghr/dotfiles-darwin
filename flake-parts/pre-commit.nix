{inputs, ...}: {
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    pre-commit.settings.hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
    };

    devShells.default = pkgs.mkShell {
      shellHook = ''
        ${config.pre-commit.shellHook}
        echo 1>&2 "Welcome to the development shell!"
      '';

      packages = config.pre-commit.settings.enabledPackages;
    };
  };
}
