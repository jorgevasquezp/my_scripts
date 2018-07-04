qsynth &
sleep 2
out=$(aconnect -o | grep client.*'FLUID Synth' | grep -o [0-9]*[\:] | sed 's/\://')
in=$(aconnect -o | grep client.*'USB Axiom 49' | grep -o [0-9]*[\:] | sed 's/\://')
echo aconnect $in $out
aconnect $in $out



