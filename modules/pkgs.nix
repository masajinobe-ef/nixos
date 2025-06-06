{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System utils
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

    # Editor
    alacritty
    neovim
    vim

    # Audio/Video
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

    # Graphic
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
    gallery-dl

    # Net
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

    # Pkgs
    ghq
    git

    # Terminal
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

    # Shell
    zsh

    # Dev
    eslint_d
    yamlfmt
    meson
    ninja
    gnumake
    pylyzer
    lua
    luajit
    luau
    nodejs
    python313
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
    codespell
    luajitPackages.luacheck
    markdownlint-cli
    nixfmt-classic
    nixfmt-rfc-style
    nixpkgs-lint-community
    nil
    prettierd
    hadolint
    rslint
    shellcheck
    shfmt
    stylelint
    stylua
    yamllint
    clang-tools
    dockerfile-language-server-nodejs
    docker-language-server
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
    llvm

    # Desktop
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

    # System software
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
