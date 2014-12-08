for i;
	do
	ffmpeg -i "$i" \
		-c:v libvpx -b:v 5M -minrate 1M -maxrate 10M -g 30 -crf 4 -pix_fmt yuv420p "${i%.*}.webm" \
		-c:v libx264 -b:v 5M -minrate 1M -maxrate 10M -g 30 -profile:v main -pix_fmt yuv420p -strict -2 "${i%.*}.mp4" \
		-c:v libtheora -b:v 5M -minrate 1M -maxrate 10M -g 30 -pix_fmt yuv420p "${i%.*}.ogv";
	done
		

