#!/usr/bin/env bash
# Shows all windows in the focused workspace; focused window styled differently.

SPACE="$(aerospace list-workspaces --focused)"
FOCUSED_APP="$INFO"  # from SketchyBar for front_app_switched
i=1

# Build/refresh items ws.1, ws.2, ...
while read -r app; do
  item="space.$SPACE.window.$i"
  sketchybar --add item "$item" left 2>/dev/null

  echo $item
  if [[ "$app" == "$FOCUSED_APP" ]]; then
    sketchybar --set "$item" drawing=on \
      label="$app" \
      label.color=0xffe6a700 \
      label.font="sketchybar-app-font:Bold:12.0" \
      background.color=0x40e6a700
  else
    sketchybar --set "$item" drawing=on \
      label="$app" \
      label.color=0xffa9b1bd \
      label.font="sketchybar-app-font:Regular:12.0" \
      background.color=0x00000000
  fi

  i=$((i+1))
done < <(aerospace list-windows --workspace "$SPACE" --format '%{app-name}')
