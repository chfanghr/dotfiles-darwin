{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.dotfiles.darwin) slim;
in
  mkIf (!slim) {
    homebrew = {
      enable = true;
      onActivation = {
        # "zap" removes manually installed brews and casks
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
      taps = [
        {
          name = "apple/apple";
          clone_target = "https://github.com/apple/homebrew-apple.git";
          force_auto_update = true;
        }
        "streetpea/streetpea"
      ];
      masApps = {
        Xcode = 497799835;
        Playgrounds = 1496833156;
        # QOL
        Discovery = 1381004916;
        # LyricsX = 1254743014;
        # Safari Plugins
        Tampermonkey = 6738342400;
        "AdGuard Mini" = 1440147259;
        "Grammarly for Safari" = 1462114288;
        "Sourcegraph for Safari" = 1543262193;
        # Steam
        "Steam Link" = 1246969117;
        # FIXME: Shadowrocket = ??? doesn't work atm
        VidHub = 1659622164;
        "WhatsApp Messenger" = 310633997;
        "NepTunes for iTunes & Spotify" = 1006739057;
      };
      brews = [
        # FIXME: requires arch -x86_64 wrapper
        # "game-porting-toolkit"
        # "game-porting-toolkit-compiler"
        "openjdk@17"
        "openjdk@21"
        "podman"
      ];
      casks = [
        "music-presence"
        "notion"
        "grammarly-desktop"
        # NOTE: use home-manager
        # "kitty"
        "foobar2000"
        "calibre"
        "utm"
        "discord"
        "visual-studio-code"
        "vlc"
        "obs"
        "keycastr"
        "xnviewmp"
        "imhex"
        "telegram"
        "signal"
        "zulip"
        "tailscale-app"
        "prismlauncher"
        "openzfs"
        "steam"
        "crossover"
        "yacreader"
        "music-presence"
        "keepingyouawake"
      ];
    };
  }
