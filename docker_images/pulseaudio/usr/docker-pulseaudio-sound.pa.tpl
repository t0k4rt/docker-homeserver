
# Create docker-pulseaudio-sound sinks
load-module module-null-sink sink_name=docker-pulseaudio-sound.input
load-module module-null-sink sink_name=docker-pulseaudio-sound.output
load-module module-pipe-sink file=/var/cache/snapcast/snapfifo sink_name=snapcast format=s16le rate=44100

# Route audio internally, loopback sinks depend on configuration. See start.sh for details:
# docker-pulseaudio-sound.input: For multiroom it's routed to snapcast sink, for standalone directly wired to docker-pulseaudio-sound.output
# docker-pulseaudio-sound.output: Set to audio sink specified by audio block
load-module module-loopback source="docker-pulseaudio-sound.input.monitor" %INPUT_SINK%
load-module module-loopback source="docker-pulseaudio-sound.output.monitor" %OUTPUT_SINK%

# Route all plugin input to the default sink
set-default-sink docker-pulseaudio-sound.input