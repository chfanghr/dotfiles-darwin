{
  config,
  pkgs,
  ...
}: let
  inherit (config.my.lib) supportedPackagesOnly;
in {
  home.packages = with pkgs;
    supportedPackagesOnly [
      shfmt
      nixpkgs-fmt
      jq
      wget
      curl
      htop
      btop
      rsync
      mosh
      wakatime-cli
      clang
      clang-tools
      cmake
      pkg-config
      fmt
      nix-tree
      nix-du
      nix-prefetch-git
      cachix
      nix-output-monitor
      nil
      nerd-fonts.jetbrains-mono
      sops
      imhex
      winbox4
      fastfetch
      bat
      sops
    ];
}
