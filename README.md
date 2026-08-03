# FFmpegCompressionScript

Some PowerShell scripts about compression with FFmpeg.

5.1 audio channel is actually a single track. But two different audio source is two tracks.

2 video track into 1 mp4 file:

 ```
 ffmpeg -i a.mp4 -i b.mp4 -map 0:v:0 -map 1:v:0 -c:v copy -an output.mp4
 ```

 draft:

 1. record still use mp4 container. multi video track and audio track should merge into 1 file.
 2. use av1 video code and av series after that.
 3. use opus audio code and opus series after that.

 lossless use png for image (apng extension in new png standard for anime image), flac for audio.

 also use jpeg image file format. consider AVIF.

 find a subtitle format.