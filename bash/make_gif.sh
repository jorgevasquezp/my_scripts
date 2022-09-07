while getopts "s:b:r:" opt; do
  case ${opt} in
    s )
      size=$OPTARG
      size=echo $size | sed 's/x/\:/'
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
		ffmpeg -i "$i"  -filter_complex "[0:v] fps=$fps [refpsd]; [refpsd] split [a][b];[a] palettegen [p];[b][p] paletteuse"  -q 0 -strict -2 -vb $vb -y ${i%.*}.gif ;
	done;
else
	for i;
		do
		ffmpeg -i "$i"  -filter_complex "[0:v] scale=$size,fps=$fps [scaled]; [scaled] split [i1][i2];[i1] palettegen [palette];[i2][palette] paletteuse" -q 0 -strict -2 -vb $vb -y ${i%.*}_$size.gif ;
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

