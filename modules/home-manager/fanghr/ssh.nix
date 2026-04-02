{config, ...}: let
  gpgCfg = config.services.gpg-agent;
in {
  programs.ssh = assert (gpgCfg.enable && gpgCfg.enableSshSupport); {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "auto";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
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
}
