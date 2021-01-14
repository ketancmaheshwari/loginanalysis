#!/bin/bash

parallel_home=/ccs/home/ketan2/summitwork/parallel-20201222/install

topdir="$HOME/summitwork/usage_snapshots"
listmonths="$topdir/Jan2020 $topdir/Feb2020 $topdir/Mar2020 $topdir/Apr2020 $topdir/May2020 $topdir/Jun2020 $topdir/Jul2020 $topdir/Aug2020 $topdir/Sep2020 $topdir/Oct2020 $topdir/Nov2020 $topdir/Dec2020"
#listmonths="$topdir/Apr2020 $topdir/May2020 $topdir/Jun2020 $topdir/Jul2020 $topdir/Aug2020 $topdir/Sep2020 $topdir/Oct2020 $topdir/Nov2020 $topdir/Dec2020"

for i in $listmonths
do
#	for j in $i/*.txt.gz
#	do
            #nice -n 19 zcat $j | grep -E -i 'pegasus|turbine|swift|fireworks|workflow|makeflow|snakemake' >> workflows_on_summit.txt
            nice -n 19 \ls $i/*.txt.gz | $parallel_home/bin/parallel -j 2 zcat {} | grep -E -i 'parsl' >> parsl_on_summit.txt
#	done
done

#sort -u workflows_on_summit.txt > tmp && mv tmp workflows_on_summit.txt

#for i in *.txt.gz
#do
#    # unique users:
#    memavailable=$(zcat $i | grep 'MemAvailable' | awk '{sum+=$2}END{print sum/(NR*1024*1024)}')
#    echo $i $memavailable >> dailyavgmemavailable.txt
#done
