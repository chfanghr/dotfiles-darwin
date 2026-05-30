{
  flake.modules.darwin.common = {
    system = {
      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };

      defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
    };
  };
}
