for i in $(cat videos);
    do
        youtube-dl -F $i;
        echo "select quality";
        read q;youtube-dl -v -j -J -f $q $i;
    done
