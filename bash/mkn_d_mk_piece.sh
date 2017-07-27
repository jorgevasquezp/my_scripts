for i;
do
	p=${proj:-SomeDCProject}
	echo $p
	new_dir=$p"_Projects_"$i
	mkdir $new_dir
	mkdir $new_dir"/2D"
	mkdir $new_dir"/2D/footage"
	mkdir $new_dir"/Sample Renders"
done;
echo -e '\a'
