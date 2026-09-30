export IFS=$'\n';
for i;
do
newdir="$(basename "$i")"
mkdir ./"$newdir";
    for j in $( find "$i" -iname *ogg -or -iname *m4v -or -iname *flac -or -iname *wav | sort );
     do
     ffmpeg -i "$j" -q 0 "$(basename "$i")/"$(basename "${j%.*}").mp3;
     done
done