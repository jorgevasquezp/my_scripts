format=bestvideo+bestaudio
format=22
while getopts ":a" opt; do
  case $opt in
    a)
      format=bestaudio
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

export IFS=$'\n';
for i;
	do 
		#Audio-->
		youtube-dl -x --audio-format vorbis --add-metadata --xattrs --embed-subs --embed-thumbnail --all-subs -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -i -f bestaudio --audio-quality 192k "$i"
		#youtube-dl --xattrs --embed-subs --embed-thumbnail --all-subs -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -i -f bestaudio "$i"
		#youtube-dl -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -f $a "$i"
		#youtube-dl --add-metadata --xattrs --embed-subs --embed-thumbnail --all-subs -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -i -f bestvideo+bestaudio "$i"
		#youtube-dl --add-metadata --xattrs --embed-subs --all-subs -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -f bestvideo+bestaudio "$i"
		#VIDEO-->
		#youtube-dl --add-metadata --xattrs --embed-subs --all-subs -o "%(playlist)s/%(playlist_index)s - %(title)s - %(format)s.%(ext)s" -i -f $format "$i"
		
done;
