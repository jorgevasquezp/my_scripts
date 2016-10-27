export n=0
for i;
	do
		ext=${i##*.};
		file=${i%.*};
		
		if [[ "$ext" = "png" || "$ext" = "jpg" ]] ;
		then
			n=$((n+1));
			mv "$i" "$(basename "$(pwd)")_$n.$ext";
		else
			mv "$i" "$(basename "$(pwd)").$ext";
		fi;
		
		
	done
exit
		

