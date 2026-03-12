{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "github:DeterminateSystems/determinate/v3.17.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microvm-nix.url = "github:microvm-nix/microvm.nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {...}: {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];
        imports = [
          inputs.git-hooks-nix.flakeModule
          ./hosts
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
    );
}
