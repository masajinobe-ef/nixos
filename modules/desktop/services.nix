{ lib
, ...
}:
{
  services = {
    acpid.enable = lib.mkAfter false;
  };
}
