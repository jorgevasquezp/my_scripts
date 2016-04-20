search_string=$1;
for i in $(find . -type d -maxdepth 1 -name '*$search_String*'); do find "$i" -type d -name '*ivery*' -exec find {} -name '*mov' \;; done
