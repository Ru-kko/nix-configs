{ ... }:

{
  # Módulos de home-manager de rukko (root no los usa).
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./nvim.nix
    ./quickshell.nix
  ];
}
