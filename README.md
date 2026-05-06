
# Video Splitter by Chapters

A simple Bash script to split a video into multiple clips based on a chapter timestamps file.

## Usage

```bash
./split_video.sh <video_file> <chapters_file> <output_folder>
```

* `video_file` – Input video (e.g., `input.mp4`)
* `chapters_file` – Text file with timestamps and labels (format: `(hh:mm:ss) Chapter Name`)
* `output_folder` – Folder to save the split clips

## Example

```bash
./split_video.sh input.mp4 chapters.txt clips
```

This will create numbered video clips in the `clips` folder.

