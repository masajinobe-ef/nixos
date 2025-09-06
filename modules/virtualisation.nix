{ lib
, ...
}:
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = [ "8.8.8.8" "8.8.4.4" ];
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
