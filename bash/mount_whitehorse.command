stty -echo
echo Waiting for silly MAC lag...
for i in {1..3};
do
	echo ...$i
	sleep 1
done
#echo mounting whitehorse
#mkdir /Volumes/whitehorse
#mount -t smbfs //mak:ale2312x@makineisilon/whitehorse /Volumes/whitehorse
#echo mounting pegasus
#mkdir /Volumes/pegasus
#mount -t smbfs //jorge:$pw@mak-nas/pegasus /Volumes/pegasus
echo done.
sleep 1
open -a trolCommander

echo ' /$$$$$$$  /$$   /$$ /$$   /$$  /$$$$$$  /$$   /$$       /$$$$$$ /$$   /$$';
echo '| $$__  $$| $$  | $$| $$$ | $$ /$$__  $$| $$  | $$      |_  $$_/| $$$ | $$';
echo '| $$  \ $$| $$  | $$| $$$$| $$| $$  \__/| $$  | $$        | $$  | $$$$| $$';
echo '| $$$$$$$/| $$  | $$| $$ $$ $$| $$      | $$$$$$$$        | $$  | $$ $$ $$';
echo '| $$____/ | $$  | $$| $$  $$$$| $$      | $$__  $$        | $$  | $$  $$$$';
echo '| $$      | $$  | $$| $$\  $$$| $$    $$| $$  | $$        | $$  | $$\  $$$';
echo '| $$      |  $$$$$$/| $$ \  $$|  $$$$$$/| $$  | $$       /$$$$$$| $$ \  $$';
echo '|__/       \______/ |__/  \__/ \______/ |__/  |__/      |______/|__/  \__/';

log_punch.sh in

sleep 25

"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" https://timeandlabor.paychex.com/secure/Login.aspx?Alias=0083A8306102 --args --"profile-direory"="Profile 2" > /tmp/chromelog.log &
stty echo

exit
