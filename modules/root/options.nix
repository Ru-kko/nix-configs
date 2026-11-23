{ lib, ... }:

{
  options = {
    vbox.enable = lib.mkEnableOption "VirtualBox guest (Guest Additions y grupo vboxsf)";

    theme = lib.mkOption {
      type = lib.types.enum [ "mocha" "latte" ];
      default = "mocha";
      description = "Tema Catppuccin global.";
    };

    configsDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/rukko/nixConfig/configs";
      description = ''
        Ruta ABSOLUTA (fuera del store) a la carpeta `configs/` del repo.
        Se usa con mkOutOfStoreSymlink para editar configs sin rebuild.
      '';
    };
  };
}
