for i;
	do ffmpeg -i "$i" -c:v libschroedinger -qscale:v 0 -c:a flac -qscale:a 0  "${i%.*}_Dirac+Flac.mkv" ;
done;
	
