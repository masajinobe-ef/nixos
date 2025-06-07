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
    libnotify

    # Editor
    alacritty
    neovim
    vim

    # Audio/Video
    audacious
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
    rustup
    gnumake
    gcc
    cmake
    clang
    clang-tools
    mold
    meson
    ninja
    lld
    lldb
    llvm
    llvmPackages_17.libllvm
    llvmPackages_17.compiler-rt
    libcxxrt
    llvmPackages_17.libcxx
    libunwind
    include-what-you-use
    clang-analyzer
    cppcheck

    hyperfine
    eslint_d
    yamlfmt
    lua
    luajit
    luau
    nodejs
    python313
    docker
    docker-buildx
    fuse-overlayfs
    go
    jq
    libiconv
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
    nixfmt-classic
    nixfmt-rfc-style
    nixpkgs-lint-community
    nil
    prettierd
    hadolint
    shellcheck
    shfmt
    stylelint
    stylua
    yamllint
    dockerfile-language-server-nodejs
    docker-language-server
    gopls
    kotlin-language-server
    lua-language-server
    marksman
    nodePackages.bash-language-server
    pyright
    ruff
    rust-analyzer
    sqls
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server

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
