{pkgs, ...}: {
  home.packages = with pkgs; [pipewire];

  home.file.".config/pipewire/pipewire.conf.d/10-null-sink.conf".text = ''
    context.objects = [
        { factory = adapter
            args = {
                factory.name     = support.null-audio-sink
                node.name        = "virtual-sink"
                node.description = "Virtual Sink"
                media.class      = Audio/Sink
                audio.position   = [ FL FR ]
            }
        }
    ]
  '';

  home.file.".config/pipewire/pipewire.conf.d/10-null-source.conf".text = ''
    context.objects = [
        { factory = adapter
            args = {
                factory.name     = support.null-audio-sink
                node.name        = "virtual-source"
                node.description = "Virtual Source"
                media.class      = Audio/Source/Virtual
                audio.position   = [ FL FR ]
            }
        }
    ]
  '';

  home.file.".config/pipewire/jack.conf.d/10-reaper.conf".text = ''
    jack.rules = [
        {
            matches = [
                {
                    application.process.binary = ".reaper-wrapped"
                }
            ]
            actions = {
                update-props = {
                    node.latency = 256/48000
                }
            }
        }
        {
            matches = [
                {
                    application.process.binary = "reaper"
                }
            ]
            actions = {
                update-props = {
                    node.latency = 256/48000
                }
            }
        }
    ]
  '';
}
