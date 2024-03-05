docker run \
    -v "${SPLEETER_AUDIO_IN_DIR-$PWD}":/input \
    -v "${SPLEETER_AUDIO_OUT_DIR-$PWD}":/output \
    -v "${SPLEETER_MODEL_DIR-$PWD}":/model \
    -e MODEL_PATH=/model \
    deezer/spleeter:3.8 \
    separate -o /output "$@"
