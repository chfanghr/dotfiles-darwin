{
  flake.modules.homeManager.fanghr = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) optionals mkMerge mkIf nameValuePair listToAttrs;
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
        zed-editor
        opencode
        element-desktop
        moonlight-qt
      ]
    );

    mkRcloneSftpHost = host:
      nameValuePair host {
        config = {
          type = "sftp";
          inherit host;
          key_use_agent = true;
          shell_type = "unix";
          known_hosts_file = "$HOME/.ssh/known_hosts";
        };
      };
  in
    mkMerge [
      (mkIf isDesktop {
        programs.rclone = {
          enable = true;
          remotes = listToAttrs [
            (mkRcloneSftpHost "hestia")
            (mkRcloneSftpHost "apollo")
          ];
        };
      })
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
    ];
}
