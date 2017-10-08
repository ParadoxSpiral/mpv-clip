# mpv-clip
Encode a clip of the current file

# Requirements
`ffmpeg` is required to be in the `$PATH`

# Usage
Place `clip.lua` in your `~/.config/mpv/scripts/` or `~/.mpv/scripts/` folder to autoload the 
script.

The script is binding itself to the `c`, `C`, and `ctrl+C` keys (overriding your `input.conf`). The
keys can be changed in the script.

`c` Sets the start point of the clip, `C` sets the end point, and `ctrl+C` starts the encode.
