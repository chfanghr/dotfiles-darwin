{
  flake.modules.homeManager.fanghr = {config, ...}: let
    gpgCfg = config.services.gpg-agent;
  in {
    programs.ssh = assert (gpgCfg.enable && gpgCfg.enableSshSupport); {
      enable = true;

      enableDefaultConfig = false;

      settings = {
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "no";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "auto";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
        "demeter.vscode" = {
          HostName = "demeter.snow-dace.ts.net";
          User = "fanghr";
        };
        "poseidon.vscode" = {
          HostName = "poseidon.snow-dace.ts.net";
          User = "fanghr";
        };
        "hestia.vscode" = {
          HostName = "hestia.snow-dace.ts.net";
          User = "fanghr";
        };
        "persephone.vscode" = {
          HostName = "persephone.snow-dace.ts.net";
          User = "fanghr";
        };
        "anemoi.vscode" = {
          HostName = "anemoi.snow-dace.ts.net";
          User = "fanghr";
        };
      };
    };
  };
}
