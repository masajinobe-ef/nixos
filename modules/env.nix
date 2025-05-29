{ ... }:

{
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
    SUDO_PROMPT = "ENTER YOUR PASSWORD: ";
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "firefox";
    UV_LINK_MODE = "copy";
    COMPOSE_BAKE = "true";
    ENABLE_DEPRECATED_TUN_ADDRESS_X = "true";
    NIX_BUILD_CORES = 0;
  };
}
