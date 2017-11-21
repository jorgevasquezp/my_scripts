export IFS=$'\n'
n=0
for i;
	do
		total=$(ls ./"$i"/*.dng | wc -l)
		for j in $(find "$i" -type f -iname '*.dng');
			do
			
			n=$(($n+1))
			#converting
			dcraw -vw -6 "$j" > .$i_dcraw_out.log 2> /dev/null;
			echo "converting" '"'$i'"' to images ":"  $((($n)*100/$total))
	done;
	ffmpeg -r 24 -i "./"$i"/"$i"_"%06d".ppm" -f mov -c:v prores_ks -profile:v 4444 -pix_fmt yuva444p10le -strict -2 -vendor ap10 $i"_@24fps.mov"
	rm *ppm
done
