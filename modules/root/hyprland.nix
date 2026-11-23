{ config, lib, ... }:

{
  programs.hyprland.enable = true;

  # Mesa/EGL: Hyprland lo necesita para inicializar el renderer.
  hardware.graphics.enable = true;

  environment.sessionVariables = {
    HYPR_THEME = config.theme;
  } // lib.optionalAttrs config.vbox.enable {
    # VirtualBox sin aceleración 3D real: render por software (llvmpipe).
    LIBGL_ALWAYS_SOFTWARE = "1";
    GALLIUM_DRIVER = "llvmpipe";
    AQ_NO_MODIFIERS = "1";
    # GTK4 (regreet) con renderer por software, más estable sobre llvmpipe.
    GSK_RENDERER = "cairo";
  };
}
