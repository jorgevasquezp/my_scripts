#!/bin/bash
for i;
	do ffmpeg -i "$i" -q 0 -c:V libx264 -profile:v main -pix_fmt yuv420p -s 1920x960 "${i%.*}_proxy.mkv";
done;
	
