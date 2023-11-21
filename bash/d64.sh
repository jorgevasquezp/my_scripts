for i;
    do
    openssl base64 -d -in "$i" -out "${i%.*}.binary_file"
done