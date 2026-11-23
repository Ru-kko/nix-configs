{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.victor-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    # Toolchain de C/C++
    gcc
    gnumake

    # Rust (blink.pairs compila su binario desde fuente)
    rustc
    cargo

    catppuccin-cursors.mochaDark
    catppuccin-cursors.latteLight
  ];
}
