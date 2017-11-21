g=6;
vb=16M;
for i;
	do ffmpeg -i "$i" -s 960x540 -c:v libx264 -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb $vb "${i%.*}_960x540_h264.mov" ;
done;
	
