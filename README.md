# mpv-clip
Encode a clip of the current file

# Requirements
`ffmpeg` is required to be in the `$PATH`

# Usage
Place `clip.lua` in your `~/.config/mpv/scripts/` or `~/.mpv/scripts/` folder to autoload the 
script.

The script is binding itself to the `c`, `C`, and `ctrl+C` keys (not overriding your `input.conf`).
The default keys can be changed in the script, or you can register the script in your `input.conf`:
```
c script_binding clip-start
C script_binding clip-end
ctrl+C script_binding clip-encode
```

`c` Sets the start point of the clip, `C` sets the end point, and `ctrl+C` starts the encode.
