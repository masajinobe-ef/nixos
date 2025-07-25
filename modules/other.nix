{ pkgs
, ...
}:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
