#!/bin/sh

# Set auto repeat speed
xset r rate 250 50

# Remove mouse acceleration
# Check prop id with xinput list
# xinput --set-prop 12 'libinput Accel Speed' 0

xinput --set-prop 'pointer:''Glorious Model O' 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 'pointer:''Glorious Model O' 'libinput Accel Speed' -0.2#
