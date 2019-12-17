#!/bin/bash

cargo build --release

parallel target/release/rav1e --bitrate {} -s 7 -l 1800 --tiles 16 ~/Videos/DOTA2_480p.y4m --low-latency -o dota_switch_{}.ivf --switch-frame-interval 30 --rdo-lookahead-frames=1 --min-keyint=240 --keyint=240 ::: 400 1000

python3 ~/Downloads/stitch.py --sequence 120:1,360:0,600:1,840:0,1080:1,1320:0,1560:1 dota_switch_1000.ivf dota_switch_400.ivf -o dota_stitched.ivf

ffmpeg -y -i dota_stitched.ivf -c:v copy dota_stitched.mp4
