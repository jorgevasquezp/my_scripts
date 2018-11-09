for i;
	do
		7z -tzip a "$i"_$(date +%m%d%y).zip "$i";
	done;
	
