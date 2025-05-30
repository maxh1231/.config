#!/bin/bash

files=(
  "eslint.config.js"
  ".prettierrc"
  "package.json"
)

mkdir -p "$HOME/Dev/projects"

for file in "${files[@]}"; do
  source="$HOME/.config/projects/$file"
  target="$HOME/Dev/projects/$file"

  if [ -e "$target" ]; then
    rm -f "$target"
  fi

  cp "$source" "$target"
  echo "Copied $file → ~/Dev/projects/$file"
done
