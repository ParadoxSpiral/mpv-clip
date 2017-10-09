# mpv-clip
Encode a clip of the current file

# Requirements
`ffmpeg`, `ffprobe`, and `youtube-dl` are required to be in the `$PATH`.
Posix `|` pipes need to be functional.

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

# Limitations
To get milisecond precision seeking working, seeking is done with the slow input seeking method.
This means, that the current file is decoded and discarded upto the start point.
