## .bash_profile
This intends to be an overly simplified and stand alone bash_profile
There are useful short function, configuration and key binding.


### useful command
### resize image
```sh
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
```

### extract
$ tar -I zstd -xvf archive.tar.zst

### resize video
```sh
ffmpeg -i full-video.mp4 -b 800k min-video.mp4
ffmpeg -i full-video.mp4 -vcodec libx264 -crf 30 min-video.mp4
```
### convert webp
libwebp (sudo apt install webp)
```sh
dwebp file.webp -o file.png
```
ffmpeg omg it can do
```sh
ffmpeg -i file.{webp,png}
ffmpeg -i file.{webp,jpg}
```

### For Arch WSL
See Yuk7 repos for download and etc.
```
Arch.exe config --default-user myuser
sc stop LxssManager
sc start LxssManager
```

### sudo setup
```
EDITOR=vim && visudo
looking for line allowing wheel group for sudo
sudo usermod -aG wheel <username>
```


### checksum and gpg
SHA256
```
sha256sum --check <<< "1f20cd153b2c32...612b3e927ba audacity-win-2.4.2.exe"
```
The `<<<` is turning string to file stdin. Alternatively,
```
echo "1f20cd153b2c32...612b3e927ba audacity-win-2.4.2.exe" | sha256sum --check
```
