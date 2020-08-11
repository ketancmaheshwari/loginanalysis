#!/bin/bash

# Anonimyze data

# list unique users
cat login*.txt | sed -n '/^w --/,/^endw --/p'|grep -v -e 'USER' -e 'load average' -e 'w --' -e 'endw --' |awk '{print $1}' | sort -u > unique.users

# Generate sed script to substitute usernames
awk 'BEGIN { print "#!/usr/bin/sed -f" } { printf("s/\\b%s\\b/u%04d/g \n", $1, num);if (length($1)>7){printf("s/\\b%s\\+\\b/u%04d/g \n", substr($1,1,7), num)}; num++ }' unique.users > tmp && mv tmp unique.users.sed

# run sed script
sed -i -f unique.users.sed login1*.txt &
sed -i -f unique.users.sed login2*.txt &
sed -i -f unique.users.sed login3*.txt &
sed -i -f unique.users.sed login4*.txt &
sed -i -f unique.users.sed login5*.txt &

wait

for i in login*.txt; do tr -s ' ' < $i > tmp.txt && mv tmp.txt $i; done

