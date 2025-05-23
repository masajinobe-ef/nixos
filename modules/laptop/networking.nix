{ ... }:

{
  networking = {
    enableIPv6 = false;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
    resolvconf.dnsSingleRequest = true;
    #nftables.enable = true;

    networkmanager = {
      enable = true;
    };

    interfaces.wlp2s0 = {
      ipv4.addresses = [
        {
          address = "192.168.0.201";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.0.1";
      interface = "wlp2s0";
    };

    firewall = {
      enable = false;
      checkReversePath = "loose";
      allowedTCPPorts = [
        33677
        80
        8080
        443
        9090
      ];
      allowedUDPPorts = [
        9
        80
        8080
        443
      ];
    };
  };
}
