export IFS=$'\n';
for i;
	do 
		youtube-dl -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -f bestaudio "$i"
		#youtube-dl -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" -f bestvideo+bestaudio "$i"
done;

	
