while getopts "s:b:" opt; do
  case ${opt} in
    s )
      height=$OPTARG
      ;;
    b )
      videorate=$OPTARG
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


if [ -z "$videorate" ]
then
	vb=16M;
else
	vb=$videorate;
fi


if [ -z "$height" ]
then
	for i;
		do ffmpeg -i "$i" -c:v libx264 -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb $vb -y "${i%.*}_h264.mp4" ;
	done;
else
	width=$(($height*16/9))
	for i;
		do ffmpeg -i "$i" -s $width'x'$height -c:v libx264 -x264opts keyint=$g:scenecut=-1 -profile:v main -pix_fmt yuv420p -q 0 -strict -2 -vb $vb -y "${i%.*}_"$width"x"$height"_h264.mp4" ;
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
