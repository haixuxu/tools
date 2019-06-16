#!/usr/bin/env bash

echo $PATH | awk -F: '{for(i=1;i<=NF;i++)print $i}'

#echo $PATH | tr ":" "\n"

#echo "${PATH//:/$'\n'}"
#tr ':' '\n' <<< "$PATH"
#perl -F: -ane '$"="\n";print "@F"' <<<"$PATH"
#perl -lne 'print for split /:/' <<<"$PATH"
#perl -pe 's/:/\n/g' <<<"$PATH"
#grep -oP '(^|:)\K[^:]+' <<<"$PATH"
#perl -0x3a -l012 -pe '' <<<"$PATH"
#awk '{split($0,arr,":"); for(var in arr) print arr[var]}' <<< $PATH
#sed 's/:/\n/g' <<< "$PATH"
#alias path='echo $PATH | tr ":" "\n"'
