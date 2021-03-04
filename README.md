## .bash_profile
This intends to be an overly simplified and stand alone bash_profile
There are useful short function, configuration and key binding.

## Paste to password prompt
Shift+Insert

## bash expansion
expansion `${var/repalce/by_string}` \
use case e.g. replace string
```
for n in $(ls prefix1_*); do
  mv $n ${n/prefix1_/prefix2_}
done
```
## Common Confusion
`$()` is for command \
`${}` is for variable \
the `"${}"` is verbose but by default `${}` is the string interpolation
```
x=world
echo "hello ${x}"
// hello world
echo "hello ${x/world/github}"
// hello github
echo "hello $(hostname -a)"
// hello 
```

## Compress PDF
```
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf input.pdf
```

## Docker tips
```
21da3r92vsd23r --> can only type 21d.. as long as it's unique
docker container diff <container_id>
docker container commit <container_id> --> make this into image
docker image tag <image_id> image_name_foo
docker image build -t hello:v0.1 ./
docker image history <image_id>
```
the specifier `image` and `container` is for beginner usage.
After getting to know docker, it can be omitted.

## curl JSON
```
curl -H "Content-Type: application/json" \
  -X POST \
  -d '{"aaa":"xx","password":"yyy"}' \
  http://localhost:3000/some/path
```
some short hand here
`-d=--data`, `-X=--request`, `-H=--header`
### curl download
```
curl -fsSL ...
```
s = silent used with S = not silent when fail
L = redirect if moved

## Image and video utils
### white bg to transparent
```
convert  your.jpg  -transparent white  your.png
```

### not 255,255,255 white
```
convert  your.jpg -fuzz 12% -transparent white  your.png
```
Change `12%` to any `XX%` you want

### Identify image size
```
identify -ping -format '%w %h' image.jpg
```
### simple resize
```
convert logo512.png -resize 150x150 logo150.png
```
### Generate favicon
```
convert -resize x16 -gravity center -crop 16x16+0+0 logo512.png -flatten -colors 256 -background transparent sample.ico
```

### resize image
```sh
convert -strip -interlace Plane -gaussian-blur 0.05 -quality 85% source.jpg result.jpg
```
### flip horizontal
```
convert -flop input.png output.png
```

### resize with fill
```
convert -background white -gravity center before.jpg -resize 200x200 -extent 200x200 after.jpg
```

### repeat command replace string 192 with string 512
```
!!:gs/192/512
```
The shorthand will only replace once
```
^192^512
```

### resize with transparent bg
```
convert logo192.png -background none -resize 192x192 -gravity center -extent 192x192 square192.png
```

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

### convert svg
```
convert -density 1200 -resize 192x192 -background white -gravity center -extent 192x192 logo-color.svg logo-192.png
convert -density 1200 -resize 512x512 -background white -gravity center -extent 512x512 logo-color.svg logo-512.png
```
## useful command

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

### extract
```
$ tar -I zstd -xvf archive.tar.zst
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
Also work on SHA1
```
sha1sum --check <<< "3e0c1edb671d2169ef0dbda7d91ffea57d7a0dc4 manjaro-xfce-20.2-201203-linux59.iso"
```

### find command findutils
```
sudo find /usr -name "*docker*" -type l -exec rm {} +
```
the plus `+` sign vs `;` semicolon is the `find` utils cryptic
```
find . -exec ls {} ;
// in some terminal need escape to
find . -exec ls '{}' \;
```
transform to
```
ls file1
ls file2
ls file3
```
but
```
find . -exec ls {} +
// in some terminal need escape to
find . -exec ls '{}' \+
```
transform to
```
ls file1 file2 file3
```
Personally I think `find ... | xargs ...` is better syntax

### find excluding dirs
```
find . \( -path ./node_modules -or -path ./.git \) -prune -false -or -type f
```
The parens`\(` , `\)` eval first then `!=-not` and final `-o=-or, -a=-and`

Pro Tips: `-path` must be **exact** otherwise use `-name`

Tips: don't print permission denied
```
find / -user aaa -group bbb 2>/dev/null | xargs cat
```
Sample cases: copy all images of repos
```
find ./ \( -path "./node_modules" -or -path ./.git -or -path ./build \) -prune -false -or -type f -regex ".*.\(jpe?g\|png\|svg\)" -exec cp {} ../mysites-assets \;
```
the `false` command prevents exiting when `-or` operator find some truthy value. This only occurs in some system.

## disk space
`du` will print in `kb`. The option `-h` is human-readable and `-b` force it to be bytes. \
512 byte = 1 block \
2 block = 1024 byte = 1 kb \
The option `-k` will make it normal `kb`. GNU du make `-k` default.
References: http://web.sxu.edu/rogers/unix/bytes.html
```
du -sh # sum all under directory
du -a # directories and file
du -a | sort -nr # most common case
```

## search file content
Excluding binary `-I`
```
grep -rI <word> <directory>
```

### ssh copy file
#### Local --> Server
Run this on local machine
```
scp -i "my_pem_file.pem" myfile.zip ubuntu@ec2-13-...-131.ap-southeast-1.compute.amazonaws.com:/home/ubuntu/
```
#### Server --> Local
Run this on local machine
```
scp root@123.123.123.123:~/path/to/that/file.txt local.txt
```
### xclip
default is primary and when specified copied to clipboard
```
xclip -selection clipboard file.txt
cat file.txt | xclip
cat file.txt | xclip -selection clipboard
```
or with "process substitution"
```
cat file.txt | tee >(xclip)
cat file.txt | tee /dev/tty | xclip
```
### Log
listing only error log
```
journalctl -p 3 -r
```
only at the current boot\
```
journalctl -p 3 -xb -r
```

### Create live USB
Finding device
```
ls -la /dev/disk/by-id
```
Write to that disk
```
sudo dd if=manjaro-xfce-20.2-201203-linux59.iso of=/dev/sdb bs=4M oflag=sync status=progress
```
Checksum
```
sudo dd if=/dev/sdb iflag=count_bytes count=2818185216 | sha1sum
```

### create fake file for testing
```
dd if=/dev/zero of=./sample-file.txt bs=1M count=1
```
Note `bs` is block size for copying NOT block size of file system `stats sample-file.txt` still show `4096` \
Note `count` is the time of copying
```
dd if=/dev/zero of=./sample-file-2.txt bs=1 count=0 seek=1M
```
The word `seek` make the system skip. This method doesn't actually copy or write anything. Just skip.
The new method is
```
fallocate -l 100M sample-file-3.txt
truncate -s 1M sample-file-3.txt
```

## Regexp Replace lowercase
replace `"WORD"`
`(".*?")`
to word `word`
`\L$1`
