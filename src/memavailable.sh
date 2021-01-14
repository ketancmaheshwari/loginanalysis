#!/bin/bash

for i in *.txt.gz
do
    # unique users:
    memavailable=$(zcat $i | grep 'MemAvailable' | awk '{sum+=$2}END{print sum/(NR*1024*1024)}')
    echo $i $memavailable >> dailyavgmemavailable.txt
done
