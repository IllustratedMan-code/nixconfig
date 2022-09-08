


color=grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | awk '{print $3}' | awk 'BEGIN{ RS = ""; FS = "\n" }{print $2}'

wl-copy $color

gum style --border "rounded" --border-foreground "$color" "$color"
