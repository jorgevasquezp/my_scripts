args="$@"
length=$(($#-1))
files=${@:1:$length}
filename=${@: -1}


if [ -f $filename ]; then
   echo "Output $filename already exists."
else
   #montage -label "\n%t" -pointsize 14 -tile 3x6 -geometry 550 -geometry +25+15 -border 1 $files $filename
   #montage -background "#77A6E4" -label "\n%t" -pointsize 12 -tile 10x6 -geometry 120 -geometry +8+4 -border 1 $files $filename
   montage -background "#77A6E4" -label "\n%t" -pointsize 12 -tile 10x6 -geometry 120 -geometry +8+4 -border 0 $files $filename
fi


