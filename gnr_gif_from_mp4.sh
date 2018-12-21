#!/bin/sh

rm -rf frames/
mkdir frames

# split mp4 frames in frames folder
ffmpeg -i demo.mp4  -r 5 'frames/%03d.jpg'
cd frames

# cut out 66% frames
for f in `ls`;
do
	fn=`echo $f|cut -f 1 -d '.'`
	num=`python -c "print(int('$fn')%3)"`
	if [ $num -ne 0 ]; then
		rm $f
	fi
done

# generate gif from reserved frames
magick convert -delay 20 -loop 0 *.jpg ../demo.gif
cd ../

# reduce gif size into 20%
magick convert demo.gif -fuzz 20% -layers Optimize output.gif
mv output.gif demo.gif
