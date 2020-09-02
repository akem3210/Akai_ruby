echo > Samples_drumkits.txt
find "/mnt/D/Samples/" | grep -i "drum" | grep -Ei "\.wav|\.ogg|\.mp3" > Samples_drumkits.txt
