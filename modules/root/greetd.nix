{ config, lib, pkgs, ... }:

let
  regreet = lib.getExe config.programs.regreet.package;
  wmConfig = pkgs.writeText "hypr-greeter.lua" ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("sh -c \"${regreet} > /tmp/regreet-debug.log 2>&1; hyprctl dispatch 'hl.dsp.exit()'\"")
    end)

    ${lib.optionalString config.vbox.enable ''
      -- VirtualBox: sin esto la pantalla no se redimensiona sola (el servicio
      -- de usuario de NixOS necesita graphical-session.target + DISPLAY).
      hl.on("hyprland.start", function()
        hl.exec_cmd("${config.virtualisation.virtualbox.guest.package}/bin/VBoxClient --foreground --vmsvga-session")
      end)
    ''}

    hl.config({
      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        disable_hyprland_guiutils_check = true,
      },
    })

    hl.env("XCURSOR_SIZE", "16")
    hl.env("XCURSOR_THEME", os.getenv("HYPR_THEME") == "latte"
      and "catppuccin-mocha-dark-cursors" or "catppuccin-latte-light-cursors")
  '';

  startHyprland = lib.getExe' config.programs.hyprland.package "start-hyprland";
in
{
  programs.regreet.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session.command = lib.mkForce
      "dbus-run-session ${startHyprland} -- -c ${wmConfig}";
  };
}
