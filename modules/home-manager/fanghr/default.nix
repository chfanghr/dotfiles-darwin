{
  imports = [
    ./gpg
    ./java.nix
    ./packages.nix
    ./shell.nix
    ./ssh.nix
    ./terminal.nix
    ./version-control.nix
  ];

  home.stateVersion = "24.11";
}
