for i;
	do ffmpeg -i "$i" -c:v libx264 -profile:v high444 -pix_fmt yuv444p -q 0 -strict -2 -g 15 "${i%.*}_hq_h264.mov" ;
done;
	
