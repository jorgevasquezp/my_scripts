while getopts "n:r:" opt; do
  case ${opt} in
    n )
      start_number=$OPTARG
      ;;
	r )
      frame_rate=$OPTARG
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

shift "$(($OPTIND -1))"



for i;
	do 
	output=$(echo $i | sed 's/_%0[[:digit:]]d//');
	ffmpeg $n $r -i "$i" -f mov -c:v prores_ks -profile:v 4444 -pix_fmt yuva444p10le -strict -2 -vendor ap10 "${output%.*}_pr4444.mov" ;
done;
