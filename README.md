# mpv-clip
Encode a clip of the current file

# Requirements
`ffmpeg`, `ffprobe`, optionally `socat` and `lua` (for `block_exit = false`), and `youtube-dl` 
(for ytdl support, duh) are required to be in the `$PATH`.
Posix `|` pipes need to be functional for youtube-dl and `block_exit = false` support.

# Usage
Place `clip.lua` in your `~/.config/mpv/scripts/` or `~/.mpv/scripts/` folder to autoload the 
script.

Adjust the script options via your mpv.conf or directly in the script to your liking.

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

Metadata handling only copies the global metadata, embedded fonts etc. are not (yet!) copied.
Chapters also don't get their time-stamp adjusted.
