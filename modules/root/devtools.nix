{ pkgs, lib, inputs, ... }:

let
  pyBuildDeps = with pkgs; [
    openssl
    zlib
    readline
    sqlite
    bzip2
    libffi
    xz
    ncurses
    gdbm
    expat
  ];

  cppflags = lib.concatMapStringsSep " " (p: "-I${lib.getDev p}/include") pyBuildDeps;
  ldflags = lib.concatMapStringsSep " " (p: "-L${lib.getLib p}/lib -Wl,-rpath,${lib.getLib p}/lib") pyBuildDeps;
  pkgConfigPath = lib.makeSearchPath "lib/pkgconfig" (map lib.getDev pyBuildDeps);

  pyenvInstall = pkgs.writeShellScriptBin "pyenv-install" ''
    export PYENV_ROOT="''${PYENV_ROOT:-$HOME/.pyenv}"
    export CPPFLAGS="${cppflags}"
    export LDFLAGS="${ldflags}"
    export PKG_CONFIG_PATH="${pkgConfigPath}"
    exec ${pkgs.pyenv}/bin/pyenv install "$@"
  '';

  nodeVersion = "22";
  pythonVersion = "3.9";
in
{
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.pyenv
    pyenvInstall
  ] ++ (with pkgs; [
    curl
    wget
    git
    gnutar
    gzip
    xz
    pkg-config
    gnumake
    gcc
    gnupatch
  ]);

  environment.interactiveShellInit = ''
    # ---- nvm (default: node ${nodeVersion}) ----
    export NVM_DIR="$HOME/.nvm"
    mkdir -p "$NVM_DIR"
    . ${inputs.nvm}/nvm.sh
    . ${inputs.nvm}/bash_completion
    nvm use default --silent >/dev/null 2>&1

    # ---- pyenv (default: python ${pythonVersion}) ----
    export PYENV_ROOT="$HOME/.pyenv"
    if [ -n "$ZSH_VERSION" ]; then
      eval "$(pyenv init - zsh)"
    else
      eval "$(pyenv init - bash)"
    fi
  '';

  # Instalación inicial en segundo plano (una sola instancia, fuera de la terminal).
  # Seguimiento: journalctl --user -fu devtools-bootstrap
  systemd.user.services.devtools-bootstrap = {
    description = "Instala node ${nodeVersion} (nvm) y python ${pythonVersion} (pyenv) por defecto";
    wantedBy = [ "default.target" ];
    path = with pkgs; [
      bash coreutils gnugrep gnused gawk findutils diffutils
      curl wget git gnutar gzip bzip2 xz
      gnumake gcc pkg-config gnupatch
      pyenv pyenvInstall
    ];
    environment = {
      NVM_DIR = "%h/.nvm";
      PYENV_ROOT = "%h/.pyenv";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = "infinity";
      Nice = 10;
    };
    script = ''
      mkdir -p "$NVM_DIR"
      . ${inputs.nvm}/nvm.sh
      if [ "$(nvm version ${nodeVersion})" = "N/A" ]; then
        nvm install ${nodeVersion}
      fi
      nvm alias default ${nodeVersion}

      if ! pyenv versions --bare | grep -q '^${pythonVersion}\.'; then
        pyenv-install -s ${pythonVersion}
      fi
      pyenv global ${pythonVersion}
    '';
  };
}
