for i;
	do ffmpeg -i "$i" -c:v libx264 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb 5000k "${i%.*}_h264.mov" ;
done;
	