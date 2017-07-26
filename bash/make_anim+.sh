#!/bin/bash
bg_color=#5d5d5d
size=1920x1080
base=smoke1
for i;
do ffmpeg -f lavfi -i color=c=$bg_color:s=$size -i $base.%04d.png -filter_complex "[0:v][1:v]overlay=shortest=1,format=yuv420p[out]" -map "[out]" -c:v qtrle -q 0 $base"_Animation+.mov";
done
