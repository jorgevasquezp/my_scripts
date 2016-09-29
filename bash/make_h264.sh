for i;
<<<<<<< HEAD
	do ffmpeg -i "$i" -c:v libx264 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb 5000k "${i%.*}_h264.mov" ;
=======
	do ffmpeg -i "$i" -c:v libx264 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 "${i%.*}_h264.mov" ;
>>>>>>> a4f1bdc7ca935a4d555d2c313b1317af6b687756
done;
	
