{ config, osConfig, ... }:

{
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.configsDir}/nvim";
}
