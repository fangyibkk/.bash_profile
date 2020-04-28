# .bash_profile
This intends to be an overly simplified and stand alone bash_profile
There are useful short function, configuration and key binding.


# useful command
# resize image
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg

# resize video
ffmpeg -i full-video.mp4 -b 800k min-video.mp4
ffmpeg -i full-video.mp4 -vcodec libx264 -crf 30 min-video.mp4
