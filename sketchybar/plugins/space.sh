#!/bin/bash

# Highlight the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0xffd79921 background.drawing=on icon.color=0xff282828
else
  sketchybar --set $NAME background.drawing=off icon.color=0xffebdbb2
fi