{ ... }:

{
  imports = [
    ./options.nix
    ./hyprland.nix
    ./greetd.nix
    ./packages.nix
    ./devtools.nix
    ../../config.nix
  ];
}
