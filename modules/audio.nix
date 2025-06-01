{
  lib,
  inputs,
  pkgs,
  ...
}:

{

  security = {

    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@realtime";
        type = "-";
        item = "rtprio";
        value = "99";
      }
      {
        domain = "@realtime";
        type = "-";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "65536";
      }
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "65536";
      }
    ];
  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';
  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';

  services = {

    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      pulse.enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      jack.enable = false;

      extraConfig.pipewire = {

        "10-custom" = {

          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 128;
            "default.clock.max-quantum" = 128;
          };

          "context.modules" = [
            {
              name = "libpipewire-module-rt";

              args = {
                "nice.level" = -20;
                "rt.prio" = 99;
                "rt.time.soft" = -1;
                "rt.time.hard" = -1;
              };

              flags = [
                "ifexists"
                "nofail"
              ];

            }

          ];

        };

        "92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 128;
            "default.clock.max-quantum" = 128;
          };

        };

      };

      extraConfig.pipewire-pulse = {

        "93-low-latency" = {

          "context.modules" = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                "pulse.min.req" = "128/48000";
                "pulse.default.req" = "128/48000";
                "pulse.max.req" = "128/48000";
                "pulse.min.quantum" = "128/48000";
                "pulse.max.quantum" = "128/48000";
                "server.address" = [ "unix:native" ];
              };
            }
          ];

          "stream.properties" = {
            "node.latency" = "128/48000";
            "resample.quality" = 1;
          };

        };

      };

    };

  };

}
