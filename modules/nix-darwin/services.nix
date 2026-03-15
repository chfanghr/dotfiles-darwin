{
  services = {
    prometheus.exporters.node.enable = true;
    openssh = {
      enable = true;
      extraConfig = ''
        PermitRootLogin no
        PasswordAuthentication no
      '';
    };
  };
}
