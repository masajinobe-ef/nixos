{ ... }:

{
  networking = {
    enableIPv6 = false; # Disable IPv6 completely
    #nftables.enable = true;

    # NetworkManager configuration
    networkmanager = {
      enable = true; # Disable NetworkManager
      unmanaged = [
        #"tun0"
      ]; # Don't manage VPN interface
      ethernet = {
        macAddress = "04:7c:16:8a:a4:b3"; # Fixed MAC address
      };
    };

    # Default network route
    defaultGateway = {
      address = "192.168.0.1"; # Router IP address
      interface = "enp42s0"; # Use Ethernet interface

      # address = "172.19.0.0";
      # interface = "tun0";
      # metric = 0;
    };

    # DNS configuration
    nameservers = [
      # "172.19.0.2"
      "8.8.8.8"
      "8.8.4.4"
    ];
    resolvconf.enable = true; # Disable resolvconf management
    resolvconf.dnsSingleRequest = true;

    # Firewall configuration
    firewall = {
      enable = false; # Enable the firewall
      checkReversePath = "loose"; # Relax source address validation
      # Sorted TCP ports with duplicates removed
      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        2080 # CPanel default
        8080 # Alternative HTTP
        9090 # Prometheus/metrics
        33677 # Custom high port
      ];
      # Sorted UDP ports
      allowedUDPPorts = [
        9 # Wake-on-LAN
        53 # DNS
        80 # HTTP
        443 # HTTPS
        8080 # Alternative HTTP
      ];
    };

    # Network interface configuration
    interfaces = {
      # Primary Ethernet interface
      enp42s0 = {
        ipv4.addresses = [
          {
            address = "192.168.0.200";
            prefixLength = 24; # /24 subnet mask (255.255.255.0)
          }
        ];
        wakeOnLan = {
          enable = true; # Enable Wake-on-LAN
          policy = [ "magic" ]; # Only allow magic packet wakes
        };
        useDHCP = false; # Disable DHCP for static config
      };
    };
  };
}
