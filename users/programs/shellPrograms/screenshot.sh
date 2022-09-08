

focused=hyprctl monitors | grep -B 6 "focused: yes" | head -1 | awk '{print $2}'
grim -o $focused
