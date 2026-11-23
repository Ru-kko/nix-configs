{ pkgs, ... }:

{
  imports = [
    ../../modules/home

  ];

  home = {
    username = "rukko";
    homeDirectory = "/home/rukko";
    stateVersion = "26.05";
    packages = with pkgs; [ ];
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    # userName / userEmail: configúralos aquí
  };
}
