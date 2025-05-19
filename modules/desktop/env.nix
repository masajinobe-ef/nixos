{ lib, ... }:

{
  environment.sessionVariables = lib.mkAfter {
    WLR_RENDERER = "vulkan";
    #CLUTTER_DEFAULT_FPS = "144";
    #__GL_SYNC_DISPLAY_DEVICE = "DP-1";
    #__GL_SYNC_TO_VBLANK = 0;
  };
}
