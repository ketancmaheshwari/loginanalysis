#!/bin/bash

source ~/.bash_profile

fname="${HOME}"/summitwork/usage_snapshots/$(hostname -f).$(date +%b%d_%Y).txt
randfname=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -c 8)

touch "${fname}"

echo "Hour $(date "+%H")" >> "${fname}"
#date "+%T" >> ${fname} #not needed because w records time.

echo 'w --' >> "${fname}"
w >> "${fname}"
echo 'endw --' >> "${fname}"

echo 'meminfo --' >> "${fname}"
cat /proc/meminfo >> "${fname}"
echo 'endmeminfo --' >> "${fname}"

echo 'vmstat --' >> "${fname}"
cat /proc/vmstat >> "${fname}"
echo 'endvmstat --' >> "${fname}"

echo 'ps aux --' >> "${fname}"
ps aux | awk '$1!~/root/' >> "${fname}"
echo 'endps aux --' >> "${fname}"

#echo 'nfs stats --' >> ${fname}
#nfsstat >> ${fname}
#nfsiostat >> ${fname}
#echo 'endnfs stats --' >> ${fname}

#echo 'iostat --' >> ${fname}
#iostat -N >> ${fname}
#echo 'endiostat --' >> ${fname}

echo 'top -n 1 -bc | awk '$2!~/root/' --' >> "${fname}"
top -n 1 -bc | awk '$2!~/root/' >> "${fname}"
echo 'endtop -n 1 -bc | awk '$2!~/root/' --' >> "${fname}"

echo 'bjobs -a -u all --' >> "${fname}"
bjobs -a -u all >> "${fname}"
echo 'endbjobs -a -u all --' >> "${fname}"

#Pattern to collect timing info only if the command succeeds. Echo fail otherwise. All spaces are crucial
#if var=$( { time (\ls /lustre/hydra/cades-nsed/world-shared > /dev/null 2>&1 ) } 2>&1 ); then echo "$var">>t.txt; else echo fail>>t.txt; fi

echo 'home response time unaliased ls --' >> "${fname}"
if var=$( { time (\ls "${HOME}" > /dev/null 2>&1) } 2>&1 ); then echo "$var">>"${fname}"; else echo fail>>"${fname}"; fi
echo 'endhome response time unaliased ls' >> "${fname}"

echo 'home response time colored ls --' >> "${fname}"
if var=$( { time (ls -thor "${HOME}" > /dev/null 2>&1) } 2>&1 ); then echo "$var">>"${fname}"; else echo fail>>"${fname}"; fi
echo 'endhome response time colored ls' >> "${fname}"

echo 'gpfs scratch response time to create a 1 G file --' >> "${fname}"
if var=$( { time (openssl rand -out "/gpfs/alpine/stf011/scratch/ketan2/${randfname}" -base64 $(( 2**30 * 3/4 )) > /dev/null 2>&1) } 2>&1 ); then echo "$var">>"${fname}"; else echo fail>>"${fname}"; fi
echo 'endgpfs scratch response time to create a 1 G file --' >> "${fname}"

rm -f "/gpfs/alpine/stf011/scratch/ketan2/${randfname}" #delete the above created file

echo 'df --' >> "${fname}"
df -h | grep -v tmpfs | grep -v none >> "${fname}"
echo 'enddf --' >> "${fname}"

echo 'endsnap' >> "${fname}"
echo ' ' >> "${fname}"
echo ' ' >> "${fname}"

