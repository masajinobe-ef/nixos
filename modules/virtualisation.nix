{ lib
, ...
}:
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = [ "8.8.8.8" "8.8.4.4" ];
      dns-opts = [ "timeout:2" "attempts:2" ];
      dns-search = [ "1.1.1.1" "77.88.8.8" ];
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
