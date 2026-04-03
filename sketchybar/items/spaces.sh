#!/bin/bash

sketchybar --add event aerospace_workspace_change

for i in 1 2 3 4 5 6 7 8 9; do
  sketchybar --add item space.$i left \
    --subscribe space.$i aerospace_workspace_change \
    --set space.$i \
    icon=$i \
    icon.padding_left=10 \
    icon.padding_right=10 \
    label.drawing=off \
    background.color=$BAR_COLOR \
    background.corner_radius=$CORNER_RADIUS \
    background.height=26 \
    background.drawing=on \
    click_script="aerospace workspace $i" \
    script="$CONFIG_DIR/plugins/aerospace_space.sh $i"
done