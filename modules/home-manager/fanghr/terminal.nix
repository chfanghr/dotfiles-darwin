{
  lib,
  config,
  ...
}: let
  inherit (lib) optionalString;
  inherit (config.my.shared.machine) isDarwin;
in {
  programs = {
    wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = let
        darwinSpecific = optionalString isDarwin ''
          config.keys = {
            -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
            {
              key = 'LeftArrow',
              mods = 'OPT',
              action = act.SendKey {
                key = 'b',
                mods = 'ALT',
              },
            },
            {
              key = 'RightArrow',
              mods = 'OPT',
              action = act.SendKey { key = 'f', mods = 'ALT' },
            }
          }
        '';
      in ''
        local wezterm = require 'wezterm'
        local act = wezterm.action
        local config = wezterm.config_builder()

        config.font = wezterm.font("JetBrains Mono")
        config.font_size = 16.0
        config.hide_tab_bar_if_only_one_tab = true

        ${darwinSpecific}

        return config
      '';
    };

    tmate.enable = true;
  };
}
