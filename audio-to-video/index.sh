#!/usr/bin/env bash


DIST='dist';
DIST_VIDEO="${DIST}/video";
mkdir -p $DIST_VIDEO;

for source in $(ls -1 ./furkies-purrkies/*/files/poetry-*.mp3 | sort -r); do
  name=$(basename -s .mp3 $source)
  destination="${DIST_VIDEO}/${name}.mp4";

  # echo $name;
  # echo $destination;
  # echo -----------------------

  execute=false;

  if [ ! -f "$destination" ]; then
    echo Audio has not yet been converted to video: $source;
    execute=true;
  else
    if [ "$source" -nt "$destination" ]; then
      echo Audio has since changed and must be re-converted to video: $source;
      execute=true;
    fi;
  fi;

  if [ "$execute" = true ] ; then
    echo creating: "${destination}";

    # ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showspectrum=s=1280x760:slide=scroll:mode=separate:color=rainbow:scale=5thrt:win_func=sine:orientation=horizontal:legend=true,format=yuv420p,crop=1562:878:0:0,split=4[a][b][c][d],[a]waveform[aa],[b][aa]vstack[V],[c]waveform=m=0[cc],[d]vectorscope=color4[dd],[cc][dd]vstack[V2],[V][V2]hstack[v]" -map "[v]" -map 0:a "${destination}"
    # ffmpeg -hide_banner -y -i "${source}" -filter_complex "[0:a]showspectrum=s=1280x760:slide=scroll:mode=separate:color=plasma:scale=5thrt:win_func=sine:orientation=horizontal:legend=true,format=yuv420p,crop=1562:878:0:0[v]" -map "[v]" -map 0:a "${destination}"


    # ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showspectrum=s=1280x760:slide=scroll:color=plasma:scale=5thrt:fscale=log:win_func=welch:legend=true:overlap=1,format=yuv420p,crop=1562:878:0:0[v]" -map "[v]" -map 0:a "${destination}"
    # ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showspectrum=s=1280x760:slide=scroll:color=plasma:scale=5thrt:fscale=log:win_func=welch:legend=true:overlap=1,format=yuv420p,crop=1562:878:0:0[v]" -map "[v]" -map 0:a  -preset superfast "${destination}"


    # USE THIS ONE:::::
    ## ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showspectrum=slide=scroll:color=plasma:scale=5thrt:fscale=log:win_func=welch:legend=true:overlap=1,format=yuv420p[v]" -map "[v]" -map 0:a  -preset superfast "${destination}"


    # ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showwaves=mode=cline:s=1920x1080[v]" -map "[v]" -map 0:a -preset superfast "${destination}"
    # ffmpeg -y -i "${source}" -filter_complex "[0:a]showwaves=mode=cline:s=1920x1080[v]" -map "[v]" -map 0:a -preset medium "${destination}"
    # ffmpeg -y -i "${source}" -filter_complex "[0:a]showwaves=mode=cline:s=1920x1080[v]" -map "[v]" -map 0:a -preset medium "${destination}"

    date;
    ffmpeg -hide_banner -loglevel panic -y -i "${source}" -filter_complex "[0:a]showwaves=s=1280x720:mode=line:rate=25:colors=gold|purple|red,format=yuv420p[v]" -map "[v]" -map 0:a -preset medium "${destination}";
    date;
  fi;
    # showspectrum=s=1280x480:scale=log

    # Use the slowest preset that you have patience for. The available presets in descending order of speed are:
    # ultrafast
    # superfast
    # veryfast
    # faster
    # fast
    # medium – default preset
    # slow
    # slower
    # veryslow
    # placebo – ignore this as it is not useful (see FAQ)



done;

# NOTES
# this is faster but less interesting: ffmpeg -y -i "${file}" -filter_complex "[0:a]showspectrum=s=1280x760:slide=scroll:mode=separate:color=plasma:scale=5thrt:win_func=sine:orientation=horizontal:legend=true,format=yuv420p,crop=1562:878:0:0[v]" -map "[v]" -map 0:a "${video}"
#spectrogram="${DIST_VIDEO}/${name}.png";     #ffmpeg -i ~/Development/poetry/db/audio/poetry-0057.mp3 -lavfi showspectrumpic=s=1024x1024 spectrogram.png
