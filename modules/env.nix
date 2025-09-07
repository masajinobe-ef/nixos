{ config
, pkgs
, ...
}:
{
  environment = {
    sessionVariables = {
      # Wayland environment
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      NIXOS_OZONE_WL = "1";
      GTK_USE_PORTAL = "1";

      # QT
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Audio
      PIPEWIRE_LATENCY = "256/48000";

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
      DOCKER_CLI_PLUGINS_PATH = "/run/current-system/sw/libexec/docker/cli-plugins";
      COMPOSE_BAKE = "true";
      ENABLE_DEPRECATED_TUN_ADDRESS_X = "true";
    };

    etc = {
      "xdg/mimeapps.list".text = ''
        [Default Applications]

        # Web
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/about=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
        text/html=firefox.desktop
        application/xhtml+xml=firefox.desktop
        application/x-extension-htm=firefox.desktop
        application/x-extension-html=firefox.desktop
        application/x-extension-shtml=firefox.desktop
        application/x-extension-xht=firefox.desktop

        # Telegram
        x-scheme-handler/tg=com.ayugram.desktop.desktop
        x-scheme-handler/telegram=com.ayugram.desktop.desktop

        # Image
        image/jpeg=ristretto.desktop
        image/png=ristretto.desktop
        image/gif=ristretto.desktop
        image/bmp=ristretto.desktop
        image/svg+xml=ristretto.desktop
        image/webp=ristretto.desktop
        image/tiff=ristretto.desktop

        # Video
        video/*=vlc.desktop
        application/ogg=vlc.desktop
        application/x-matroska=vlc.desktop

        # Audio
        audio/*=audacious.desktop

        # Torrent
        application/x-bittorrent=qbittorrent.desktop
        x-scheme-handler/magnet=qbittorrent.desktop

        # Text
        text/plain=alacritty.desktop
        text/x-c=alacritty.desktop
        text/x-c++=alacritty.desktop
        text/x-python=alacritty.desktop
        application/x-shellscript=alacritty.desktop

        # Archive
        application/zip=org.gnome.FileRoller.desktop
        application/x-rar=org.gnome.FileRoller.desktop
        application/x-7z-compressed=org.gnome.FileRoller.desktop
        application/x-tar=org.gnome.FileRoller.desktop
        application/gzip=org.gnome.FileRoller.desktop

        # Nautilus
        inode/directory=org.gnome.Nautilus.desktop
      '';

      "xdg/applications/com.ayugram.desktop.desktop".text = ''
        [Desktop Entry]
        Name=AyuGram Desktop
        Comment=Desktop version of AyuGram - ToS breaking Telegram client
        TryExec=ayugram-desktop
        Exec=env DESKTOPINTEGRATION=1 ayugram-desktop -- %u
        Icon=ayugram
        Terminal=false
        StartupWMClass=AyuGram
        Type=Application
        Categories=Chat;Network;InstantMessaging;Qt;
        MimeType=x-scheme-handler/tg;x-scheme-handler/tonsite;
        Keywords=tg;chat;im;messaging;messenger;sms;telegram;tdesktop;
        Actions=quit;
        DBusActivatable=true
        SingleMainWindow=true
        X-GNOME-UsesNotifications=true
        X-GNOME-SingleWindow=true

        [Desktop Action quit]
        Exec=ayugram-desktop -quit
        Name=Quit AyuGram
        Icon=application-exit
      '';
    };
  };

  system.activationScripts.mimeDatabase = ''
    if [ -x "$(command -v update-mime-database)" ]; then
      update-mime-database -n /run/current-system/sw/share/mime
    fi
  '';

  system.activationScripts.desktopDatabase = ''
    if [ -x "$(command -v update-desktop-database)" ]; then
      update-desktop-database /run/current-system/sw/share/applications
    fi
  '';
}
