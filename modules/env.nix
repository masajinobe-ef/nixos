{ ...
}:
{
  environment.sessionVariables = {
    # Wayland environment
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
    # Core tools
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    # Terminal/color settings
    TERM = "xterm-256color";
    COLORTERM = "truecolor";
    # Miscellaneous
    SUDO_PROMPT = "ENTER YOUR PASSWORD: ";
    UV_LINK_MODE = "copy";
    COMPOSE_BAKE = "true";
    ENABLE_DEPRECATED_TUN_ADDRESS_X = "true";
  };
}
