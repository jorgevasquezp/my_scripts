for i;
do
	curr_proj="DC_WTR"
	new_dir=$curr_proj"_Projects_"$i
	mkdir $new_dir
	mkdir $new_dir"/2D"
	mkdir $new_dir"/2D/footage"
	mkdir $new_dir"/Sample Renders"
done;
echo -e '\a'
