#casa
#wacom_id=10
#makine
#wacom_id="Wacom Intuos Pro M Pen stylus"
#wacom_id=$(xsetwacom --list devices | grep stylus | grep -o [0-9]. | sed 's/\t//')
#wacom_id=$(xsetwacom --list devices | grep 'stylus' | grep 'id:.[0-9]' -o | grep '[0-9]' -o)
wacom_id=$(xsetwacom --list devices | grep 'stylus' | grep -E 'id:.[0-9]{1,3}' -o | grep -E '[0-9]{1,3}' -o)

xsetwacom --set "$(($wacom_id + 0))" button 2 3
xsetwacom --set "$(($wacom_id + 0))" button 3 2
xsetwacom --set "$(($wacom_id + 0))" threshold 50
