{
  flake.modules.homeManager.fanghr = {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableScDaemon = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = ./main.gpg;
          trust = 5;
        }
      ];
    };
  };
}
