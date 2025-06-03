{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Системные утилиты
    acpid
    age
    alsa-utils
    android-tools
    btop
    fastfetch
    home-manager
    iproute2
    libcap
    lsof
    lynis
    sops
    libnotify

    # Разработка и инструменты сборки
    arduino-cli
    arduino-core
    avrdude
    clang
    cmake
    docker
    docker-buildx
    fuse-overlayfs
    gcc
    go
    jq
    libiconv
    lld
    llvm
    luarocks
    pnpm
    ruby
    rustfmt
    slirp4netns
    tree-sitter
    uv
    yq

    # Редакторы и IDE
    alacritty
    neovim
    vim

    # Аудио/Видео
    ffmpeg
    helvum
    mpv
    obs-studio
    pavucontrol
    pipewire
    qjackctl
    spek
    vlc
    wireplumber
    yt-dlp

    # Графика и изображения
    exiftool
    imagemagick
    inkscape
    krita
    libva
    libva-utils
    libvdpau
    libvdpau-va-gl
    libvpx
    mesa
    xfce.ristretto
    xfce.tumbler

    # Сетевые инструменты
    bluetuith
    dnsmasq
    dnsutils
    dnscrypt-proxy
    filezilla
    gvisor
    iptables
    nekoray
    nftables
    qbittorrent
    wget

    # Управление пакетами и версиями
    ghq
    git

    # Терминальные утилиты
    eza
    fd
    fzf
    ripgrep
    tmux
    tmuxp
    tree
    ueberzugpp
    yazi
    zoxide

    # Оболочки
    zsh

    # Языки программирования
    lua
    luajit
    luau
    nodejs
    python313

    # Линтеры и форматеры
    codespell
    eslint_d
    golangci-lint
    hadolint
    ktlint
    luajitPackages.luacheck
    markdownlint-cli
    nixfmt-classic
    nixfmt-rfc-style
    nil
    prettierd
    rubocop
    shellcheck
    shfmt
    stylelint
    stylua
    yamllint

    # LSP-серверы
    clang-tools
    dockerfile-language-server-nodejs
    gopls
    kotlin-language-server
    lua-language-server
    marksman
    nodePackages.bash-language-server
    pyright
    python3Packages.python-lsp-server
    ruff
    rust-analyzer
    sqls
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server

    # Рабочий стол и GUI
    gnome-control-center
    gnome-keyring
    gnome-session
    gnome-shell
    grim
    mako
    onlyoffice-bin
    papirus-icon-theme
    redshift
    rofi-wayland
    slurp
    swaybg
    swayidle
    swaylock
    waybar
    wl-clipboard
    xdg-utils

    # Системное ПО
    librewolf-bin
    httrack
    megacmd
    p7zip
    stow
    taplo
    unrar
    unzip
    zip
  ];
}
