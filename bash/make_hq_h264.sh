g=8;
vb=32M;
for i;
	do ffmpeg -i "$i" -c:v libx264 -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb $vb "${i%.*}_h264.mov" ;
done;
	
