{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pinentry_mac
    curl
    rsync
    cachix
    htop
    coreutils
    file
    zellij
    gnupg
    vfkit
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
