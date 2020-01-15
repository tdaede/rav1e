#!/bin/bash

cargo build --release

parallel target/release/rav1e --tune Psnr --bitrate {} -s 10 -l 1800 --tiles 16 ~/Videos/raw-852x480.y4m --low-latency -o dota_switch_{}.ivf --switch-frame-interval 30 --rdo-lookahead-frames=1 --min-keyint=240 --keyint=240 ::: 1500 600 200

python3 ~/Downloads/stitch.py --sequence 120:1,360:0,600:1,840:0,1080:1,1320:0,1560:1 dota_switch_1500.ivf dota_switch_600.ivf -o dota_stitched.ivf

ffmpeg -y -i dota_stitched.ivf -c:v copy dota_stitched.mp4
