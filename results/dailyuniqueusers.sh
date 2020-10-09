for i in *
do
    # unique users:
    numusers=$(zcat $i | sed -n '/^w --/,/^endw --/p'|grep -v -e 'USER' -e 'load average' -e 'w --' -e 'endw --' |awk '{print $1}' | sort -u|wc -l)
    echo $i $numusers >> dailyusers.txt
done
