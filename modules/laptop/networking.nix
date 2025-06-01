{
  pkgs,
  lib,
  ...
}:

{

  networking = {

    defaultGateway = lib.mkForce {
      address = "192.168.0.1";
      interface = "wlp2s0";
    };

    interfaces = lib.mkForce {

      wlp2s0 = {
        ipv4.addresses = [
          {
            address = "192.168.0.210";
            prefixLength = 24;
          }
        ];
        wakeOnLan = {
          enable = true;
          policy = [ "magic" ];
        };
        useDHCP = false;
      };

    };

  };

}
