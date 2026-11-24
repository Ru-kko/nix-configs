{ pkgs, config, osConfig, ... }:

{
  home.packages = with pkgs; [ chafa ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.configsDir}/nvim";
}
