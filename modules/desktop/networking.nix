{ ... }:

{
  networking = {
    enableIPv6 = false;

    networkmanager = { enable = true; };

    interfaces.enp42s0 = {
      ipv4.addresses = [{
        address = "192.168.0.200";
        prefixLength = 24;
      }];
      wakeOnLan.policy = [ "magic" ];
    };

    defaultGateway = {
      address = "192.168.0.1";
      interface = "enp42s0";
    };

    firewall = {
      enable = false;
      checkReversePath = "loose";
      allowedTCPPorts = [ 33677 80 8080 443 9090 ];
      allowedUDPPorts = [ 9 80 8080 443 ];
    };
  };
}
