{ config, lib, ... }:

{
  system.stateVersion = "26.05";

  # VM con BIOS (no UEFI): solo GRUB
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Red
  networking = {
    hostName = "Rukko";
    networkmanager.enable = true;
  };

  # Zona horaria
  time.timeZone = "America/Bogota";

  # Teclado (consola y X11/Wayland)
  console.keyMap = "us";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.virtualbox.guest.enable = lib.mkIf config.vbox.enable true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

}
