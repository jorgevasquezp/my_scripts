for i;
	do ffmpeg -i "$i" -g 15 -s 1280x720 -c:v libx264 -profile:v main -pix_fmt yuv420p -strict -2 -q 0 -b:v 18000k "${i%.*}_h264.mov" ;
done;
	
