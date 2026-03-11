{
  description = "A flake template for nix-darwin and Determinate Nix";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs = {self, ...} @ inputs: let
    # The values for `username` and `system` supplied here are used to construct the hostname
    # for your system, of the form `${username}-${system}`. Set these values to what you'd like
    # the output of `scutil --get LocalHostName` to be.
    # Your system username
    username = "fanghr";

    # Your system type (Apple Silicon)
    system = "aarch64-darwin";

    hostname = "Dioscuri";
  in {
    # nix-darwin configuration output
    darwinConfigurations.${hostname} = inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.determinate.darwinModules.default
        inputs.home-manager.darwinModules.default
        ./modules/nix-darwin
      ];
    };

    # Development environment
    devShells.${system}.default = let
      pkgs = import inputs.nixpkgs {inherit system;};
    in
      pkgs.mkShellNoCC {
        packages = with pkgs; [
          # Shell script for applying the nix-darwin configuration.
          # Run this to apply the configuration in this flake to your macOS system.
          (writeShellApplication {
            name = "apply-nix-darwin-configuration";
            runtimeInputs = [
              # Make the darwin-rebuild package available in the script
              inputs.nix-darwin.packages.${system}.darwin-rebuild
            ];
            text = ''
              echo "> Applying nix-darwin configuration..."

              echo "> Running darwin-rebuild switch as root..."
              sudo darwin-rebuild switch --flake ".#${hostname}"
              echo "> darwin-rebuild switch was successful ✅"

              echo "> macOS config was successfully applied 🚀"
            '';
          })

          self.formatter.${system}
        ];
      };

    # Nix formatter

    # This applies the formatter that follows RFC 166, which defines a standard format:
    # https://github.com/NixOS/rfcs/pull/166

    # To format all Nix files:
    # git ls-files -z '*.nix' | xargs -0 -r nix fmt
    # To check formatting:
    # git ls-files -z '*.nix' | xargs -0 -r nix develop --command nixfmt --check
    formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt;
  };
}
