{ pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    # A
    acpid
    alacritty
    android-tools
    audacious

    # B
    bash-language-server
    baobab
    blueman
    bluez
    bluez-alsa
    bluez-tools
    btop

    # C
    cachix
    clang
    clang-tools
    codespell
    curl

    # D
    docker
    docker-buildx
    dockerfile-language-server-nodejs
    docker-language-server
    dnsutils

    # E
    eslint_d
    eza
    exiftool

    # F
    fastfetch
    fd
    ffmpeg
    firefox
    fzf

    # G
    ghq
    git
    gnome-control-center
    gnome-keyring
    gnome-session
    gnome-shell
    go
    gnumake
    grim
    gtk3

    # H
    hadolint
    helvum
    home-manager
    hyperfine

    # I
    imagemagick
    inkscape

    # J
    jq

    # K
    kdePackages.dolphin
    krita

    # L
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugins
    libva
    libva-utils
    libvdpau
    libvdpau-va-gl
    libvpx
    lua-language-server
    luajit
    luajitPackages.luacheck
    luarocks

    # M
    mako
    marksman
    megacmd
    mesa
    mpv

    # N
    neovim
    nil
    nix-tree
    nixpkgs-fmt
    nodejs

    # O
    obs-studio
    onlyoffice-bin

    # P
    p7zip
    papirus-icon-theme
    pavucontrol
    pipewire
    pnpm
    prettierd
    python313

    # Q
    qbittorrent
    qpwgraph
    qt5.qtwayland
    qt6.qtwayland
    qt6ct

    # R
    redshift
    ripgrep
    rofi-wayland
    ruff
    rust-analyzer
    rustfmt

    # S
    shellcheck
    shfmt
    slurp
    stow
    stylua
    swaybg
    swayidle
    swaylock

    # T
    tailwindcss-language-server
    taplo
    tmux
    tmuxp
    tree-sitter
    typescript-language-server

    # U
    ueberzugpp

    # V
    vim
    vlc

    # W
    waybar
    wget
    wireplumber
    wl-clipboard

    # X
    xdg-utils
    xfce.ristretto
    xfce.tumbler

    # Y
    yaml-language-server
    yamllint
    yamlfmt
    yazi
    yq
    yt-dlp

    # Z
    zoxide
    zsh
  ];
}
