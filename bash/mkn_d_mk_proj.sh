for i;
do
	p=${proj:-SomeDCProject}
	echo $p
	new_dir=$p"_"$i
	mkdir $new_dir
	mkdir $new_dir"/"$p"_Projects"
	mkdir $new_dir"/"$p"_Renders"
	mkdir $new_dir"/"$p"_Extra"
done;
echo -e '\a'
