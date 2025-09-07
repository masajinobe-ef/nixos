{ pkgs
, ...
}:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      kdePackages.xdg-desktop-portal-kde
    ];
    wlr.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
