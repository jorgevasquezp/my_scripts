<<<<<<< HEAD
search_string="$1";
echo $search_string;
find . -n "'*$search_string*'";

=======
search_string=$1;
for i in $(find . -type d -maxdepth 1 -name '*$search_String*'); do find "$i" -type d -name '*ivery*' -exec find {} -name '*mov' \;; done
>>>>>>> a4f1bdc7ca935a4d555d2c313b1317af6b687756
