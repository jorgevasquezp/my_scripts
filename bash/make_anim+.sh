#!/bin/bash
bg_color=#5d5d5d
size=1920x1080
for i;
do ffmpeg -f lavfi -r 23.976 -i color=c=$bg_color:s=$size -start_number 0001 -r 23.976 -i $i%04d.png -filter_complex "[0:v][1:v]overlay=shortest=1,format=yuv420p[out]" -map "[out]" -c:v qtrle -q 0 $i"_Animation+.mov";
done
