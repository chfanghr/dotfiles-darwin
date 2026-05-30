{
  flake.modules.homeManager.fanghr = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkIf;
    inherit (config.my.lib) isPackageSupported;
    inherit (config.my.shared.inheritable.env) isSlim;

    preferedJavaPackage = pkgs.graalvmPackages.graalvm-ce;
    javaPackage =
      if isPackageSupported preferedJavaPackage
      then preferedJavaPackage
      else pkgs.jvm;
  in
    mkIf (!isSlim) {
      programs.java = {
        enable = true;
        package = javaPackage;
      };
    };
}
