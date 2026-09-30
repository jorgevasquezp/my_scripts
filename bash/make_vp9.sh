alpha="false"

while getopts "a" opt; do
  case ${opt} in
    a )
      alpha="true"
      ;;
  esac
done

shift "$(($OPTIND -1))"

for i;
do
	echo $alpha
	new_name=$(echo $i | sed -Er 's/\_(NL|PR)([_-])/\_VP9\2/');
	if [ "$alpha" = "true" ]
	then
		
		ffmpeg -i "$i" -c:v libvpx-vp9 -pix_fmt yuva420p -b:v 0 -colorspace bt709 -color_trc bt709 -color_primaries bt709 -crf 10 -auto-alt-ref 0 "${new_name%.*}.webm" ##-vf "alphaextract" -c:v libvpx-vp9 -pix_fmt yuva420p -b:v 0 -colorspace bt709 -color_trc bt709 -color_primaries bt709 -crf 5 "${new_name%.*}_ALPHA.webm";
		echo $new_name "w alpha"
	else
		ffmpeg -i "$i" -c:v libvpx-vp9 -pix_fmt yuv420p -b:v 0 -colorspace bt709 -color_trc bt709 -color_primaries bt709 -crf 10 "${new_name%.*}.webm";
		echo $new_name
		echo $new_name "no alpha"
	fi

done;
