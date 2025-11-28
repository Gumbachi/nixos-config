#!/bin/sh

# This script changes the default audio and subtitle track for every mkv file in the working directory
# View the track info with mkvinfo and set the tracks to the corresponding values

# Probably necessary to set other tracks to 0 to ensure the default track gets recognized
# Modify the tracks in this file as needed

for f in ./*.mkv; do
  mkvpropedit "$f" \
  -e track:a1 -s flag-default=0 \
  -e track:a2 -s flag-default=1 \
  -e track:s1 -s flag-default=1
done
