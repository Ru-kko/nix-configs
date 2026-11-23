{ config, lib, inputs, hostname, ... }:

{
  users.mutableUsers = true;

  users.users.rukko = {
    isNormalUser = true;
    description = "Rukko";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ]
      ++ lib.optional config.vbox.enable "vboxsf";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs hostname; };

    users = {
      root = import ./root;
      rukko = import ./rukko;
    };
  };
}
