hl.on("hyprland.start", function()
  hl.exec_cmd("quickshell")

  -- VirtualBox: redimensionado automático de pantalla (solo si VBoxClient existe)
  hl.exec_cmd("sh -c 'command -v VBoxClient >/dev/null && exec VBoxClient --foreground --vmsvga-session'")
end)
