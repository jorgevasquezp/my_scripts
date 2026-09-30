for i;
do
search=$( exiftool -s3 -artist -title "$i" | xargs )
echo $search
syncedlyrics "$search" --synced-only -o "${i%.*}.lrc"
done