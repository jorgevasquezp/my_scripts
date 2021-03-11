for i;
do 
	real_ext=$(file $i | cut -d':' -f2 | cut -d' ' -f2)
	##echo $ext
	if [ $real_ext == "JPEG" ];
	then
		ext="jpg"
	elif [ $real_ext == "TIFF" ];
	then
		ext="tif"
	else
		ext=$real_ext
	fi
	new_ext=${ext,,}
	mv $i ${i%.*}.$new_ext	
done
