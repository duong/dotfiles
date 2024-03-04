# Disable beep
xset -b

# Start compositor for fancy visuals
picom &

# Unclutter - hide the mouse cursor
unclutter --jitter 10 --ignore-scrolling --start-hidden --fork

# Nitrogen for wallpaper
# nitrogen --set-zoom-fill ~/Pictures/yuri-catppuccin.png &

# xwallpaper for wallpaper
xwallpaper --center ~/Pictures/yuri-catppuccin.png &

# from original
qtile start

# set auto repeat speed
xset r rate 250 50

# from qtile website
#exec qtile start
