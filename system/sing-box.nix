{ config, pkgs, ... }:

{
  services.sing-box.enable = true;

  systemd.services.sing-box = {
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
    after = [ "network.target" "sops-nix.service" ];
  };

  sops.secrets = {
    sing-box-uuid = { };
    sing-box-public-key = { };
    sing-box-short-id = { };
  };

  services.sing-box.settings = {
    dns = {
      rules = [
        {
          domain = [ "access.temnomor.ru" "dns.google" ];
          server = "dns-direct";
        }
        {
          outbound = [ "any" ];
          server = "dns-direct";
        }
      ];
      servers = [
        {
          address = "https://dns.google/dns-query";
          address_resolver = "dns-direct";
          strategy = "ipv4_only";
          tag = "dns-remote";
        }
        {
          address = "https://223.5.5.5/dns-query";
          address_resolver = "dns-local";
          detour = "direct";
          strategy = "ipv4_only";
          tag = "dns-direct";
        }
        {
          address = "local";
          detour = "direct";
          tag = "dns-local";
        }
        {
          address = "rcode://success";
          tag = "dns-block";
        }
      ];
    };

    inbounds = [
      {
        endpoint_independent_nat = true;
        address = [ "172.19.0.1/28" ];
        route_address = [ "0.0.0.0/1" "128.0.0.0/1" ];
        mtu = 9000;
        stack = "gvisor";
        tag = "tun-in";
        type = "tun";
      }
      {
        listen = "127.0.0.1";
        listen_port = 2080;
        tag = "mixed-in";
        type = "mixed";
      }
    ];

    log = { level = "warn"; };

    outbounds = [
      {
        flow = "xtls-rprx-vision";
        packet_encoding = "";
        server = "access.temnomor.ru";
        server_port = 443;
        tls = {
          enabled = true;
          insecure = false;
          reality = {
            enabled = true;
            public_key = config.sops.secrets.sing-box-public-key.path;
            short_id = config.sops.secrets.sing-box-short-id.path;
          };
          server_name = "www.google.com";
          utls = {
            enabled = true;
            fingerprint = "chrome";
          };
        };
        uuid = config.sops.secrets.sing-box-uuid.path;
        type = "vless";
        tag = "proxy";
      }
      {
        tag = "direct";
        type = "direct";
      }
      {
        tag = "bypass";
        type = "direct";
      }
    ];

    route = {
      auto_detect_interface = true;
      rule_set = [ ];
      rules = [
        {
          action = "hijack-dns";
          port = [ 53 ];
        }
        {
          action = "hijack-dns";
          protocol = [ "dns" ];
        }
        {
          action = "reject";
          ip_cidr = [ "224.0.0.0/3" "ff00::/8" ];
          source_ip_cidr = [ "224.0.0.0/3" "ff00::/8" ];
        }
      ];
    };
  };
}
