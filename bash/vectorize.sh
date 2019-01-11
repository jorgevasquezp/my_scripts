## requires inkscape potrace npm npm(svg-join) imagemagick
# for all 
extra="-k .85"
# for spray
#extra="-t 1 -u 1.5 -k .75"
temp="temp.png"
for i;
	do 
	ppm_file="${i%.*}.ppm"
	png_file="${i%.*}.png"
	convert -size 512x512 xc:#00000000 $temp
	
	for j in $(identify -format "%[scene] " "$i");
	do 
		if [ $j -gt 0 ]
		then
			psd_layer=$i[$j];
			g=$(identify -format "%[g]" $i[$j]);
			out_layer=${i%.*}_layer-$j
			
			color=$(convert $psd_layer -alpha off -resize 1x1 TXT:- | grep -oE "[\#0-9ABCDEF]{7}")
			
			if [ $((0x${color:1:2})) -lt 60 ]
				then
				$(true)
				color="#000000"
				else
				if [ $color = "#FFFFFF" ]
					then
						$(true)
					#echo "Uno blanco"
					else
					#echo "Uno gris"
					color="#888888"
				fi
				
			fi
			
			
			
			
			composite $psd_layer -geometry $g  $temp $out_layer.png;
			convert $out_layer.png -alpha extract -negate -normalize $out_layer.ppm;
			rm  $out_layer.png;
			#potrace $out_layer.ppm -b svg --flat --progress $extra;
			potrace $out_layer.ppm -b svg --flat $extra;
			#cat $out_layer.svg | echo sed "s/#000000/$(echo $color)/"
			#cat $out_layer.svg | sed "s/#000000/$(convert $psd_layer -alpha off -resize 1x1 TXT:- | grep -oE "[\#0-9ABCDEF]{7}")/" > tmp.svg
			cat $out_layer.svg | sed "s/#000000/$color/" > tmp.svg
			mv tmp.svg $out_layer.svg
			rm  $out_layer.ppm;
		fi
	
	done
		
	#convert "$i" -layers composite -alpha extract -extent 512x512 $png_file;
	#convert "$i" -background white -flatten $ppm_file;
	
	#potrace $ppm_file -b svg --flat --progress -t 1 -u 1.5 -k $k
	#potrace $ppm_file -b svg --flat --progress $extra
	#base_name=${ppm_file%.*} 
	#inkscape -f $base_name.svg -E $base_name.eps
	#rm $ppm_file $base_name.svg
	done
svgs=$(ls ${i%.*}*svg)
mergesvg.py $svgs ${i%.*}.svg
#inkscape -f ${i%.*}.svg -E ${i%.*}.eps
#rm ${i%.*}.svg
rm $(echo $svgs)
rm $temp
