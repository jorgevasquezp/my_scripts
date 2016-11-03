#crop to a centered square
export square_crop="crop=in_h:in_h:(in_w-in_h)/2:0"

b=8M;
min=16M;
max=64M;
g=6;

for i;
	do
	ffmpeg -ss $slate -i "$i" \
		-c:v libx264 -b:v $b -minrate $min -maxrate $max -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 1:1 -q 0 -aspect 1:1 -vf "scale=-1:in_h" "${i%.*}_instagram_facebook.mp4"		
	done

#-c:v libx264 -b:v $b -minrate $min -maxrate $max -filter:v "$square_crop" -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 1:1 -q 0 -s 1080x1080 "${i%.*}_instagram.mp4"
#-c:v libx264 -b:v $b -minrate $min -maxrate $max -filter:v "$square_crop" -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 1:1 -q 0 -s 1080x1080 "${i%.*}_facebook.mp4"
