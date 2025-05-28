{ pkgs, ... }:

{
  system.stateVersion = "25.05";

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      sandbox = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.udev.extraRules = ''
    # Disable wakeup for all USB devices
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"

    # Arduino fix
    KERNEL=="ttyACM[0-9]*", MODE="0666"

    # Disable wakeup for USB controllers (xHCI)
    #ACTION=="add", SUBSYSTEM=="pci", DRIVER=="xhci_hcd", ATTR{power/wakeup}="disabled"
  '';

  users.users.masa = {
    isNormalUser = true;
    description = "masa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "seat"
      "audio"
      "realtime"
      "input"
      "dialout"
      "docker"
    ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = false;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
}
