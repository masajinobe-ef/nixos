{ pkgs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    # Software
    acpid
    btop
    fastfetch
    home-manager
    libnotify
    firefox
    httrack
    megacmd
    p7zip
    stow
    unrar
    unzip
    zip
    alacritty
    neovim
    vim
    exiftool
    imagemagick
    inkscape
    krita
    xfce.ristretto
    xfce.tumbler
    audacious
    ffmpeg
    mpv
    obs-studio
    spek
    vlc
    yt-dlp
    ghq
    git
    qbittorrent
    wget
    bluetuith
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
    zsh
    onlyoffice-bin

    # Desktop
    gnome-control-center
    gnome-keyring
    gnome-session
    gnome-shell
    grim
    mako
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

    # Audio/Video
    pavucontrol
    pipewire
    wireplumber

    # Graphic
    libva
    libva-utils
    libvdpau
    libvdpau-va-gl
    libvpx
    mesa

    # Dev
    nixpkgs-fmt
    gnumake
    clang
    clang-tools
    hyperfine
    eslint_d
    yamlfmt
    luajit
    nodejs
    python313
    docker
    docker-buildx
    go
    jq
    luarocks
    pnpm
    ruby
    rustfmt
    tree-sitter
    uv
    yq
    codespell
    luajitPackages.luacheck
    nil
    prettierd
    hadolint
    shellcheck
    shfmt
    stylua
    yamllint
    taplo

    # LSP
    ruff
    rust-analyzer
    marksman
    bash-language-server
    dockerfile-language-server-nodejs
    docker-language-server
    lua-language-server
    tailwindcss-language-server
    typescript-language-server
    yaml-language-server
  ];
}
