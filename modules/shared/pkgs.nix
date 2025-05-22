{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development Tools
    vim
    neovim
    git
    stow
    ghq
    gcc
    clang
    gnumake
    go
    python313
    ruff
    ruff-lsp
    nixfmt-rfc-style
    prettierd
    stylua
    nodejs
    pnpm
    uv
    docker
    jq
    yq
    cmake
    llvm
    lld
    libiconv

    # Terminal Utilities
    alacritty
    zsh
    tmux
    tmuxp
    eza
    fzf
    fd
    ripgrep
    zoxide
    tree
    yazi
    ueberzugpp
    libcap
    ventoy-full
    woeusb
    ntfs3g

    # Networking & Security
    wget
    qbittorrent
    dnsmasq
    dnscrypt-proxy
    dnsutils
    gvisor
    iptables
    nftables
    acpid
    iproute2

    # System Utilities & Security
    fastfetch
    btop
    sops
    age
    lynis

    # Multimedia & Graphics
    xfce.ristretto
    xfce.tumbler
    krita
    obs-studio
    inkscape
    ffmpeg
    yt-dlp
    mpv
    vlc
    imagemagick
    exiftool
    mesa
    libvdpau
    libva
    libva-utils
    libvdpau-va-gl

    # Desktop Environment & Wayland Tools
    gnome-keyring
    gnome-session
    gnome-shell
    gnome-control-center
    xdg-utils
    redshift
    papirus-icon-theme
    qt5.qtwayland
    wl-clipboard
    grim
    slurp
    swaylock
    swayidle
    waybar
    rofi-wayland
    mako
    swaybg

    # Archive Utilities
    p7zip
    unrar
    zip
    unzip

    # Audio
    pavucontrol

    # Web Browser
    firefox
  ];
}
