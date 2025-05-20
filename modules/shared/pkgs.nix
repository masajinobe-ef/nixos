{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Development Tools ---
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

    # --- Terminal Environment ---
    alacritty
    zsh
    tmux
    tmuxp

    # --- CLI Utilities ---
    eza
    fzf
    fd
    ripgrep
    zoxide
    tree
    yazi
    ueberzugpp
    libcap

    # --- Networking & Privacy ---
    wget
    qbittorrent
    dnsmasq
    dnscrypt-proxy
    dnsutils
    sing-box
    v2ray
    v2raya
    gvisor
    zapret
    iptables
    nftables

    # --- System Management ---
    acpid
    fastfetch
    btop
    sops
    age
    lynis

    # --- Media & Graphics ---
    xfce.ristretto
    xfce.tumbler
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

    # --- Desktop Environment ---
    gnome-keyring
    gnome-session
    gnome-shell
    gnome-control-center
    xdg-utils
    redshift
    papirus-icon-theme
    qt5.qtwayland

    # --- Wayland Ecosystem ---
    wl-clipboard
    grim
    slurp
    swaylock
    swayidle
    waybar
    rofi-wayland
    mako
    swaybg

    # --- Archive Handling ---
    p7zip
    unrar
    zip
    unzip

    # --- Audio Control ---
    pavucontrol

    # --- Applications ---
    firefox
    ayugram-desktop
  ];
}
