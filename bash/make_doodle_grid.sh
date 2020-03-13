d=Detailed;
s=Simple;
bg_color=#77A6E4

for i in $(ls $d)
	do
	new_image=./"${i%.*}.ppm"
	new_simple_image=./"${i%.*}_simple.ppm"
	convert ./$d/$i[0] -background $bg_color -flatten $new_image;
	convert ./$s/${i%.*}_simple.psd[0] -background $bg_color -flatten $new_simple_image;
	sidebyside=./"sidebyside_"${i%.*}.ppm
	grid=$(basename $(pwd))".jpg"
	montage -background "#77A6E4" -label "\n%t" -pointsize 10 -tile 1x2 -geometry 100 -geometry +0+0 -border 0 $new_image $new_simple_image $sidebyside
	rm $new_image
	rm $new_simple_image
	done
	
montage -background "#77A6E4" -tile 10x10 -geometry +15+5 -border 1 sidebyside*ppm $grid
rm *sidebyside*

#for i in {Detailed,Simple};
	#do
		#for j in $(ls $i)
			#do
			#convert ./$i/$j[0] -background "#77A6E4" -flatten ./"${j%.*}.ppm";
		#done
		#make_grid.sh *ppm $(basename $(pwd))"$i.jpg";
		#rm *ppm
	#done
