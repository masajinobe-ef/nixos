#!/usr/bin/env bash

# Get volume data from PipeWire
volume_line=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

# Handle errors if no audio device
if [ $? -ne 0 ]; then
  echo '{"text":" N/A", "tooltip":"No audio device", "class":"error"}'
  exit 0
fi

# Extract volume and mute status
volume=$(awk '{print $2}' <<<"$volume_line")
muted=$(grep -q "MUTED" <<<"$volume_line" && echo true || echo false)

# Convert to percentage (0-100)
volume_percent=$(awk -v vol="$volume" 'BEGIN {printf "%d\n", vol * 100 + 0.5}')

# Set icons and class based on state
if $muted || [ "$volume_percent" -eq 0 ]; then
  icon=" " # Muted icon (Font Awesome)
  class="muted"
elif [ "$volume_percent" -lt 50 ]; then
  icon=" " # Low volume icon
  class="normal"
else
  icon=" " # High volume icon
  class="normal"
fi

# Output JSON for Waybar
echo "{\"text\":\"$icon $volume_percent%\", \"tooltip\":\"Volume: $volume_percent%\", \"class\":\"$class\"}"
