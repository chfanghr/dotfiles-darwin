{
  flake.modules.darwin.common = {
    lib,
    pkgs,
    config,
    ...
  }: let
    inherit (config.my.shared.inheritable.env) isDesktop;
    inherit (lib) mkMerge mkIf;
  in
    mkMerge [
      {
        environment.systemPackages = with pkgs; [
          pinentry_mac
          curl
          rsync
          htop
          coreutils
          file
        ];

        programs = {
          zsh = {
            enable = true;
            enableBashCompletion = true;
          };
          gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
          };
          tmux.enable = true;
          nix-index.enable = true;
          man.enable = true;
        };
      }
      (mkIf isDesktop {
        programs.nix-index.enable = true;
        programs.nix-index-database.comma.enable = true;
      })
      (mkIf (!isDesktop) {
        programs.nix-index.enable = false;
      })
    ];
}
