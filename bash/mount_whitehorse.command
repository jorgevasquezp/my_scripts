stty -echo
echo Waiting for silly MAC lag...
for i in {1..3};
do
	echo ...$i
	sleep 1
done
echo mounting whitehorse
mkdir /Volumes/whitehorse
mount -t smbfs //mak:ale2312x@makineisilon/whitehorse /Volumes/whitehorse
echo mounting pegasus
mkdir /Volumes/pegasus
mount -t smbfs //jorge:Ladilla2@mak-nas/pegasus /Volumes/pegasus
echo done.
sleep 1
open -a trolCommander
open -a adium

stty echo

exit
