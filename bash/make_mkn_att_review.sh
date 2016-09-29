for i;
	do ffmpeg -i "$i" -s 960x540 -b:v 900k -b:a 64k -g 15 "${i%.*}.wmv" ;
done;
	
