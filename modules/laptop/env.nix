{
  lib,
  ...
}:

{

  environment.sessionVariables = lib.mkAfter {

    #TERM = "xterm-256color";

  };

}
