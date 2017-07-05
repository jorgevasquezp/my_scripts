for i;
	do ffmpeg -i "$i" -f mov -c:v prores_ks -profile:v 4444 -pix_fmt yuva444p10le -strict -2 -vendor ap10 "${i%.*}_pr4444.mov" ;
done;
