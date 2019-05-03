while getopts "n:r:w:b:" opt; do
  case ${opt} in
    n )
      start_number=$OPTARG
      ;;
	r )
      frame_rate=$OPTARG
      ;;
    w )
      imax=$OPTARG
      ;;
    b )
      imin=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done

if [ -z "$start_number" ]
then
	n=;
else
	n='-start_number '$start_number;
fi

if [ -z "$frame_rate" ]
then
	r=;
else
	r='-r '$frame_rate;
fi

if [ -z "$imax" ]
then
	w=;
else
	w='-vf colorlevels=rimax='$imax':gimax='$imax':bimax='$imax'';
fi

if [ -z "$imin" ]
then
	b=;
else
	b=':rimin='$imin':gimin='$imin':bimin='$imin'';
fi

shift "$(($OPTIND -1))"



for i;
	do 
	output=$(echo $i | sed 's/_%0[[:digit:]]d//');
	ffmpeg $n $r -i "$i" $w$b -f mp4 -c:v libx264 -profile:v main -pix_fmt yuv420p -strict -2 -crf 16 -bf 0 "${output%.*}_h264.mp4" ;
done;
##ffmpeg $n $r -i "$i" $w$b -f mp4 -c:v libx264 -profile:v main -pix_fmt yuv420p -strict -2 -crf 16 -movflags faststart -bf 0 "${output%.*}_h264.mp4" ;
##ffmpeg $n $r -i "$i" $w$b -f mov -c:v prores_ks -profile:v 4444 -pix_fmt yuva444p10le -strict -2 -vendor ap10 "${output%.*}_pr4444.mov" ;
