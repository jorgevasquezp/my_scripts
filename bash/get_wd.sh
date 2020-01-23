#/usr/bin/bash
for i;
	do 
	link=$(curl $i | grep -o --color=auto 'http[^"]*\=view' | sed 's,\\,,g');
	wget $link;
	done
for i in *mp4*; do mv $i ${i%\?*}; done
