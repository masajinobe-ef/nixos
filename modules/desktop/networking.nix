{
  pkgs,
  lib,
  ...
}:

{

  networking = {

    defaultGateway = lib.mkForce {
      address = "192.168.0.1";
      interface = "enp42s0";
    };

    interfaces = lib.mkForce {

      enp42s0 = {
        useDHCP = false;

        ipv4.addresses = [
          {
            address = "192.168.0.200";
            prefixLength = 24;
          }
        ];

        wakeOnLan = {
          enable = true;
          policy = [ "magic" ];
        };

      };

    };

  };

}
