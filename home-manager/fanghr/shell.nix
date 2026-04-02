{nvfModules, ...}: {
  lib,
  config,
  ...
}: let
  inherit (lib) optionalString optionalAttrs;
  inherit (config.my.shared.machine) isDarwin;
  inherit (config.my.shared.inheritable.env) isGamingRig;
in {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    ripgrep.enable = true;

    zellij = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    zsh = {
      enable = true;
      enableVteIntegration = true;

      history = {
        size = 1000000;
        path = "$HOME/.local/share/zsh/history";
      };

      initContent = let
        darwinSpecific = optionalString isDarwin ''
          export PATH=/usr/local/zfs/bin:$PATH
        '';
      in ''
        ${darwinSpecific}
      '';

      shellAliases =
        {
          ssh-dont-check-host-key = ''ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'';
        }
        // optionalAttrs isDarwin {fuck-bluetooth = "sudo pkill bluetoothd";}
        // optionalAttrs (isDarwin && isGamingRig) (
          let
            toggleMetalHud = state: "defaults write -g MetalForceHudEnabled -bool ${
              if state
              then "YES"
              else "NO"
            }";
          in {
            turn-on-metal-hud = toggleMetalHud true;
            turn-off-metal-hud = toggleMetalHud false;
          }
        );

      prezto = {
        enable = true;
        prompt = {
          theme = "smiley";
          showReturnVal = true;
          pwdLength = "short";
        };
        terminal.autoTitle = true;
        syntaxHighlighting.highlighters = [
          "main"
          "brackets"
          "pattern"
          "line"
          "root"
        ];
        pmodules = [
          "git"
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
          "syntax-highlighting"
          "history-substring-search"
          "autosuggestions"
          "rsync"
          "ssh"
          "osx"
        ];
      };
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    man.enable = true;

    nvf = {
      enable = true;
      enableManpages = true;
      defaultEditor = true;
      settings = nvfModules.common;
    };
  };

  services.pueue.enable = true;

  home.shell.enableZshIntegration = true;
}
