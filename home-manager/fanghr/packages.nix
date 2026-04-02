{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) optionals mkMerge mkIf;
  inherit (config.my.lib) supportedPackagesOnly;
  inherit (config.my.shared.machine) isDarwin;
  inherit (config.my.shared.inheritable.env) isSlim isDesktop;

  basicPackages = with pkgs; [
    curl
    mosh
    rsync
    htop
    bat
    sops
    jq
  ];

  extraCliPackages = optionals (!isSlim) (
    with pkgs; [
      shfmt
      nixpkgs-fmt
      wget
      btop
      clang
      clang-tools
      cmake
      pkg-config
      fmt
      nix-tree
      nix-du
      nix-output-monitor
      sops
      fastfetch
      nil
    ]
  );
  desktopPackages = optionals isDesktop (
    with pkgs; [
      nerd-fonts.jetbrains-mono
      imhex
      winbox4
      wakatime-cli
    ]
  );
in
  mkMerge [
    {
      home.packages = supportedPackagesOnly (basicPackages ++ extraCliPackages ++ desktopPackages);
      fonts.fontconfig.enable = isDesktop;
    }
    (mkIf isDarwin {
      targets.darwin = {
        linkApps.enable = false;
        copyApps = {
          enable = true;
          # enableChecks = false;
        };
      };
    })
  ]
