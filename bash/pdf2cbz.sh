for i;
do
    pdf=$i
    new_folder=${i%.*}
    mkdir "$new_folder"
    pdfimages "$i" -j "$new_folder"/page_
    7z a -tzip "$new_folder".cbz "$new_folder"
    rm -R "$pdf" "$new_folder"
done
