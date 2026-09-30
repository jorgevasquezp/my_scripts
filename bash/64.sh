for i;
    do
    openssl base64 -in "$i" -out "${i%.*}_base64.txt"
done