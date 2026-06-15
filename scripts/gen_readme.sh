#!/usr/bin/env bash

# Script for generating README.md with wallpaper previews

IMG_DIR="../preview"
OUT="../README.md"

# Ensure we run from the script's own directory
cd "$(dirname "$0")" || exit 1

echo "# My Wallpaper Collection" > "$OUT"
echo "<sub>*Note: Previews are displayed below in low resolution for faster loading.*</sub>" >> "$OUT"
echo "" >> "$OUT"
echo "<table>" >> "$OUT"

count=0

while IFS= read -r img; do
    relative_img="${img#../}"
    
    if (( count % 2 == 0 )); then
        printf "  <tr>\n    <td><img src=\"%s\" width=\"400\"></td>\n" "$relative_img" >> "$OUT"
    else
        printf "    <td><img src=\"%s\" width=\"400\"></td>\n  </tr>\n" "$relative_img" >> "$OUT"
    fi
    ((count++))
done < <(find "$IMG_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | sort)

if (( count % 2 == 1 )); then
    printf "    <td></td>\n  </tr>\n" >> "$OUT"
fi

echo "</table>" >> "$OUT"

echo "" >> "$OUT"
echo "Total Wallpapers: $count" >> "$OUT"
