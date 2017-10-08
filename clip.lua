-- Copyright (C) 2017  ParadoxSpiral
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Parabot.  If not, see <http://www.gnu.org/licenses/>.


-- Encode a clip of the current file
-- TODO: Use higher precision than seconds

local mp = require 'mp'
local options = require 'mp.options'
local os = require 'os'

-- Options
local o = {
    -- Key bindings
    key_set_start_frame = "c",
    key_set_stop_frame = "C",
    key_start_encode = "ctrl+C",

    -- Audio settings
	audio_codec = "libopus",
	audio_bitrate = "192k",

	-- Video settings
	video_codec = "libx265",
	video_crf = "25",
	video_pixel_format = "yuv420p10",
	video_resolution = nil, -- source resolution if not specified

	-- Misc settings
	encoding_preset = "fast",
	output_directory = "/tmp",
	clear_start_stop_on_encode = true,
}
options.read_options(o)

-- Global mutable variables
local start_frame = nil
local stop_frame = nil

function encode()
	if not start_frame then 
		mp.osd_message("No start frame set!")
		return
	end
	if not stop_frame then
		mp.osd_message("No stop frame set!")
		return
	end

	local out = o.output_directory.."/"..mp.get_property("media-title").."-clip-"..start_frame.."-"..
		stop_frame..".mkv"
	local res
	if o.video_resolution then
		res = o.video_resolution
	else
		res = mp.get_property("width").."x"..mp.get_property("height")
	end
	local saf = start_frame
	local sof = stop_frame
	if o.clear_start_stop_on_encode then
		start_frame = nil
		stop_fram = nil
	end

	mp.osd_message("Starting encode from "..saf.." to "..sof.." into "..out)
	local time = os.time()

	-- TODO: handle youtube-dl URLs
	-- FIXME: Chapters don't get their time adjusted
	os.execute("ffmpeg -ss "..saf..' -i "'..mp.get_property("path")..'" -to '..sof-saf..
		" -c:a "..o.audio_codec.." -b:a "..o.audio_bitrate.." -c:v "..o.video_codec..
		" -pix_fmt "..o.video_pixel_format.." -crf "..o.video_crf.." -s "..res..
		" -preset "..o.encoding_preset..' "'..out..'"')

	mp.osd_message("Finished encode of "..out.." in "..os.time()-time.." seconds", 5000)
end

-- TODO: Switch away from _forced_
-- Start frame key binding
mp.add_forced_key_binding(o.key_set_start_frame,
	function()
		start_frame = mp.get_property("playback-time")
	end)
-- Stop frame key binding
mp.add_forced_key_binding(o.key_set_stop_frame,
	function()
		stop_frame = mp.get_property("playback-time")
	end)
-- Start encode key binding
mp.add_forced_key_binding(o.key_start_encode,
	function()
		encode()	
	end)

-- Reset start/stop frame when a new file is loaded
mp.register_event("start-file",
	function()
		start_frame = nil
		stop_frame = nil
	end)
