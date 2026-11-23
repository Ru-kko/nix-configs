{ pkgs, config, osConfig, ... }:

{
  home.packages = with pkgs; [
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.qtwayland
  ];

  home.sessionVariables.HYPR_THEME = osConfig.theme;

  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.configsDir}/hypr";
}
