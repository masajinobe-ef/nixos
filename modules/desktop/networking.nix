{
  networking = {
    enableIPv6 = false;
    #nftables.enable = true;

    networkmanager = {
      enable = true;
      unmanaged = [ ];
    };

    defaultGateway = {
      address = "192.168.0.1";
      interface = "enp42s0";
    };

    interfaces = {
      enp42s0 = {
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
        useDHCP = false;
      };
    };

    resolvconf.enable = true;
    resolvconf.dnsSingleRequest = true;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowedTCPPorts = [
        9
        53
        80
        443
        2080
        8080
        9090
        33677
      ];
      allowedUDPPorts = [
        9
        53
        80
        443
        2080
        8080
        9090
        33677
      ];
    };
  };
}
