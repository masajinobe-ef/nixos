{
  lib,
  ...
}:

{

  environment.sessionVariables = lib.mkAfter {

    WLR_RENDERER = "vulkan";

  };

}
