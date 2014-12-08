for i;
	do ffmpeg -i "$i" -s 960x540 -c:v libx264 -profile:v main -pix_fmt yuv420p -strict -2 "${i%.*}_h264.mov" ;
done;
	
