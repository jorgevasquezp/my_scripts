#casa
#wacom_id=10
#makine
#wacom_id="Wacom Intuos Pro M Pen stylus"
wacom_id=$(xsetwacom --list devices | grep stylus | grep -o [0-9].)
xsetwacom --set "$wacom_id" button 2 3
xsetwacom --set "$wacom_id" button 3 2


