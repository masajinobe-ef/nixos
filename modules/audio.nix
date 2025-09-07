{ lib
, inputs
, pkgs
, ...
}:
{
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = false;

      wireplumber = {
        enable = true;
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/99-volume-limit.conf" ''
            context.properties = {
              default.volume.limit = 1.0
            }
          '')
        ];
      };

      extraConfig.pipewire = {
        "10-custom" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 256;
            "default.volume.limit" = 1.0;
          };
          "context.modules" = [{
            name = "libpipewire-module-rt";
            args = {
              "nice.level" = -15;
              "rt.prio" = 88;
              "rt.time.soft" = 200000;
              "rt.time.hard" = 200000;
            };
            flags = [ "ifexists" "nofail" ];
          }];
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        "context.properties" = { };
        "context.modules" = [{
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.req" = "256/48000";
            "pulse.default.req" = "256/48000";
            "pulse.max.req" = "256/48000";
            "pulse.min.quantum" = "256/48000";
            "pulse.max.quantum" = "256/48000";
            "pulse.max.volume" = "1.0";
          };
        }];
        "stream.properties" = {
          "node.latency" = "256/48000";
          "resample.quality" = 1;
        };
      };
    };
  };
}
