# Disable beep
xset -b

# Start compositor for fancy visuals
picom &

# Unclutter - hide the mouse cursor
unclutter --jitter 10 --ignore-scrolling --start-hidden --fork

# Nitrogen for wallpaper
nitrogen --set-zoom-fill ~/Pictures/yuri-catppuccin.png &

qtile start
