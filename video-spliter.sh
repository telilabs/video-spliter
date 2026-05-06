#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <video_file> <chapters_file> <output_folder>"
    exit 1
fi

VIDEO_FILE="$1"
CHAPTERS_FILE="$2"
OUTPUT_DIR="$3"

# Create output folder if it doesn't exist
mkdir -p "$OUTPUT_DIR"

i=1
while IFS= read -r line || [ -n "$line" ]; do
    [[ -z "$line" ]] && continue

    if [[ "$line" =~ ^\(([0-9]{2}:[0-9]{2}:[0-9]{2})\)\ *(.*) ]]; then
        start="${BASH_REMATCH[1]}"
        label="${BASH_REMATCH[2]// /_}"

        # Peek at next line for end time
        read -r next_line || next_line=""
        if [[ "$next_line" =~ ^\(([0-9]{2}:[0-9]{2}:[0-9]{2})\) ]]; then
            end="${BASH_REMATCH[1]}"
        else
            end=""
        fi

        output_file="${OUTPUT_DIR}/${i}_${label}.mp4"

        # Run ffmpeg
        if [ -n "$end" ]; then
            ffmpeg -i "$VIDEO_FILE" -ss "$start" -to "$end" -c copy "$output_file"
        else
            ffmpeg -i "$VIDEO_FILE" -ss "$start" -c copy "$output_file"
        fi

        i=$((i + 1))

        # If next_line was a timestamp, put it back for next iteration
        if [[ "$next_line" =~ ^\([0-9]{2}:[0-9]{2}:[0-9]{2}\) ]]; then
            line="$next_line"
            continue
        fi
    fi
done < "$CHAPTERS_FILE"

