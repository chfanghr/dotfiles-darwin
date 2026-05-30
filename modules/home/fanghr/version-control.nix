{
  flake.modules.homeManager.fanghr = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) getExe;
    inherit (config.programs) nvf;

    nvim = assert nvf.enable; getExe nvf.finalPackage;
  in {
    home.packages = [pkgs.sops];

    programs = {
      git = {
        enable = true;

        signing.format = "openpgp";

        settings = {
          user = {
            name = "Hongrui Fang";
            email = "chfanghr@gmail.com";
          };

          core = {
            autocrlf = "input";
            editor = nvim;
          };

          init.defaultBranch = "main";

          "diff \"sopsdiffer\"".textconv = "sops -d";

          alias = rec {
            lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
            lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
            lg = lg1;
            hh = "rev-parse HEAD";
          };
        };

        lfs.enable = true;

        ignores = [
          "*~"
          ".DS_Store"
          ".direnv"
          ".vscode"
          ".idea"
          "result"
          "result-*"
        ];
      };

      jujutsu = {
        enable = true;
        ediff = false;

        settings = {
          user = {
            name = "Hongrui Fang";
            email = "chfanghr@gmail.com";
          };
          ui = {
            editor = nvim;
          };
        };
      };

      difftastic = {
        enable = true;
        git.enable = true;
      };
    };
  };
}
