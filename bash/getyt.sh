qurl="https://www.youtube.com/results?search_query="
qstring="Octonauts Poison Dart Frogs"

for i;

<<<<<<< HEAD
        do temp=$(curl -s $qurl$(echo $i | sed 's/\s/+/g') | grep -o href\=\"\/watch\?v\=[^\"]* | head -1)
        code=$(echo $temp | sed 's/href\=\"\/watch\>?v\=//')
        echo $code
        youtube-dl -f bestvideo+bestaudio "https://www.youtube.com/watch?v="$code
=======
	do temp=$(curl -s $qurl$(echo $i | sed 's/\s/+/g') | grep -o href\=\"\/watch\?v\=[^\"]* | head -1)
	code=$(echo $temp | sed 's/href\=\"\/watch\>?v\=//')
	echo $code
	youtube-dl -f bestvideo+bestaudio "https://www.youtube.com/watch?v="$code
>>>>>>> 65bebded8069a0b359ab8c1007a68e2991542aaf
done;
