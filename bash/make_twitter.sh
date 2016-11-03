#crop to a centered square
export square_crop="crop=in_h:in_h:(in_w-in_h)/2:0"

bv=6M;
ba=128K;
g=6;

for i;
	do
	ffmpeg -ss $slate -i "$i" \
		-c:v libx264 -b:a $ba -b:v $bv -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 16:9 -q 0 -vf "scale=-1280:720" "${i%.*}_twitter.mp4"		
	done

#-c:v libx264 -b:v $b -minrate $min -maxrate $max -filter:v "$square_crop" -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 1:1 -q 0 -s 1080x1080 "${i%.*}_instagram.mp4"
#-c:v libx264 -b:v $b -minrate $min -maxrate $max -filter:v "$square_crop" -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -strict -2 -movflags faststart -aspect 1:1 -q 0 -s 1080x1080 "${i%.*}_facebook.mp4"
