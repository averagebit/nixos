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
}
