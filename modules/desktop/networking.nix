{ pkgs
, lib
, ...
}:
{
  networking = {
    useDHCP = false;
    useNetworkd = false;
    defaultGateway = {
      address = "192.168.0.1";
      interface = "enp42s0";
    };
    interfaces = {
      enp42s0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.0.200";
            prefixLength = 24;
          }];
          routes = [{
            address = "0.0.0.0";
            prefixLength = 0;
            via = "192.168.0.1";
          }];
        };
        wakeOnLan = {
          enable = true;
          policy = [ "magic" ];
        };
      };
    };
  };
}
