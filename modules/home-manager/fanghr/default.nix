{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
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
    ];

    stateVersion = "24.11";
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;

      userName = "Hongrui Fang";
      userEmail = "chfanghr@gmail.com";

      lfs.enable = true;

      difftastic.enable = true;

      ignores = [
        "*~"
        ".DS_Store"
        ".direnv"
        ".vscode"
        ".idea"
        "dist-newstyle/"
        "clear\\ /"
      ];

      aliases = rec {
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
        lg = lg1;
        hh = "rev-parse HEAD";
      };

      extraConfig = {
        core = {
          autocrlf = "input";
          editor = "${config.programs.neovim.package}/bin/nvim";
        };
        init.defaultBranch = "main";
        "diff \"sopsdiffer\"".textconv = "sops -d";
      };
    };

    home-manager.enable = true;

    java = {
      enable = true;
      package = pkgs.graalvmPackages.graalvm-ce;
    };

    man.enable = true;

    neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      defaultEditor = true;
    };

    ripgrep.enable = true;

    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "~/.ssh/master-%r@%h:%p";

      matchBlocks = {
        "demeter.vscode" = {
          hostname = "demeter.snow-dace.ts.net";
          user = "fanghr";
        };
        "poseidon.vscode" = {
          hostname = "poseidon.snow-dace.ts.net";
          user = "fanghr";
        };
        "hestia.vscode" = {
          hostname = "hestia.snow-dace.ts.net";
          user = "fanghr";
        };
        "persephone.vscode" = {
          hostname = "persephone.snow-dace.ts.net";
          user = "fanghr";
        };
        "anemoi.vscode" = {
          hostname = "anemoi.snow-dace.ts.net";
          user = "fanghr";
        };
      };
    };

    zellij.enable = true;

    zsh = {
      enable = true;
      enableVteIntegration = true;

      history = {
        size = 1000000;
        path = "$HOME/.local/share/zsh/history";
      };

      initContent = ''
               if [[ -r "$HOME/.iterm2_shell_integration.zsh" ]]; then
                 source "$HOME/.iterm2_shell_integration.zsh"
               fi

               export GPG_TTY="$(tty)"

        export PATH=/usr/local/zfs/bin:$PATH
      '';

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

    alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "JetBrainsMono Nerd Font Mono";
          size = 18;
        };
        colors = {
          primary = {
            background = "0x000000";
            foreground = "0xffffff";
          };
        };
      };
    };

    wezterm = {
      enable = true;
      enableZshIntegration = true;
    };

    difftastic.git.enable = true;
  };

  services.pueue.enable = true;
}
