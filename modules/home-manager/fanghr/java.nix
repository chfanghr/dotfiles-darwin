{
  config,
  pkgs,
  ...
}: let
  inherit (config.my.shared.lib) isPackageSupported;
  preferedJavaPackage = pkgs.graalvmPackages.graalvm-ce;
  javaPackage =
    if isPackageSupported preferedJavaPackage
    then preferedJavaPackage
    else pkgs.jvm;
in {
  programs.java = {
    enable = true;
    package = javaPackage;
  };
}
