export IFS=$'\n';
for i;
	do 
	for j in $(cat "$i");
	do
		cp "$j" .
	done;
done;
	
