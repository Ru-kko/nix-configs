{ pkgs, config, osConfig, ... }:

let
  themeDir = "${pkgs.kitty-themes}/share/kitty-themes/themes";

  themes = {
    mocha = "${themeDir}/Catppuccin-Mocha.conf";
    latte = "${themeDir}/Catppuccin-Latte.conf";
  };

  # Tema según config.nix, con fallback a mocha
  theme = themes.${osConfig.theme or "mocha"} or themes.mocha;
in
{
  # kitten icat usa imagemagick para mostrar formatos que no soporta nativamente
  home.packages = [ pkgs.imagemagick ];

  programs.kitty = {
    enable = true;
    extraConfig = ''
      include ${osConfig.configsDir}/kitty/kitty.conf
      include ${theme}
    '';
  };
}
