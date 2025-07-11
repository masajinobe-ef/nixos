{ ...
}:
{
  hardware = {
    graphics = {
      enable = true;
    };
    bluetooth = {
      enable = false;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "bredr";
          MaxControllers = "2";
        };
      };
    };
  };
}
