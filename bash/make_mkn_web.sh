b=8M;
min=16M;
max=64M;
g=6;

for i;
	do
	ffmpeg -ss $slate -i "$i" \
		-c:v libx264 -b:v $b -minrate $min -maxrate $max -vf "setfield=prog" -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -q 0 "${i%.*}_web.mp4"
	done
