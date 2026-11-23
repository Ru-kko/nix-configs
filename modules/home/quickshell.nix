{ pkgs, config, osConfig, ... }:

{
  home.packages = [ pkgs.quickshell ];

  # Symlink fuera del store: editar configs/quickshell se aplica sin rebuild.
  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${osConfig.configsDir}/quickshell";
}
