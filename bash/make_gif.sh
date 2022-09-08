while getopts "s:b:r:" opt; do
  case ${opt} in
    s )
      size=$OPTARG
      sizealt=$(echo $size | sed 's/x/\:/')
      ;;
    b )
      vb=$OPTARG
      ;;
    r )
      fps=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done

shift "$(($OPTIND -1))"

g=6;
color=999999;


if [ -z "$fps" ]
then
     r=59.9;
else
	r=$fps;
fi


if [ -z "$size" ]
then
	for i;		
		do
		d=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$i");
		w=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of default=noprint_wrappers=1:nokey=1 "$i");
		h=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of default=noprint_wrappers=1:nokey=1 "$i");
		ffmpeg -i "$i"  -filter_complex "[0:v] fps=$fps [refpsd]; gradients=size="$w"x"$h":d=$d:c0=$color:c1=$color [box];  [refpsd] split [a][b];[a] palettegen [p];[box][b] overlay [overlayed];[overlayed][p] paletteuse"  -q 0 -strict -2 -vb $vb -y ${i%.*}.gif ;
	done;
else
	for i;
		do
		echo $size 
		d=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$i");
		ffmpeg -i "$i"  -filter_complex "[0:v] scale=$sizealt,fps=$fps [scaled]; gradients=size=$size:d=$d:c0=$color:c1=$color [box],[box][scaled] overlay [overlayed],[overlayed] split [i1][i2];[i1] palettegen [palette];[i2][palette] paletteuse" -q 0 -strict -2 -vb $vb -y ${i%.*}_$size.gif ;
	done;
fi	


#/Volumes/pegasus/01_PROJECTS/18060_DSDC035_25_Days_Of_Christmas_2018/09_Graphics/05_Graphics_Output/01_GFX_Scenes/103018

get_project_base () {
	dir=$(pwd)
	IFS='/' read -r a discs_root disc folder project a <<<"$dir"
	echo "/$discs_root/$disc/$folder/$project"
}
get_todays_review_folder (){
	base=$(get_project_base)
	review_folder=$(ls $base | grep -i review)
	echo $base/$review_folder
}

#get_todays_review_folder

