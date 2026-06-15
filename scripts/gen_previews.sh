#!/usr/bin/env bash

# Script for generating low-res wallpaper previews

WALLPAPER_DIR="../wallpapers"
PREVIEW_DIR="../preview"

# Ensure we run from the script's own directory
cd "$(dirname "$0")" || exit 1

# Ensure preview directory exists
mkdir -p "$PREVIEW_DIR"

echo "Generating low-res previews..."
count=0

while IFS= read -r img; do
    filename=$(basename "$img")
    preview_img="$PREVIEW_DIR/$filename"
    
    # Check if preview already exists and is newer than the wallpaper
    if [ ! -f "$preview_img" ] || [ "$img" -nt "$preview_img" ]; then
        echo "Processing: $filename"
        # Resize to a max width of 500px while maintaining aspect ratio
        magick "$img" -resize 500x "$preview_img"
        ((count++))
    fi
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | sort)

echo "Done! Generated $count new preview(s)."
