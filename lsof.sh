#!/bin/bash

TMPFILE1=$(mktemp)
TMPFILE2=$(mktemp)
TMPFILE3=$(mktemp)

pid=$(awk '{print $1}' /proc/[0-9]*/stat 2> /dev/null | sort -h)

echo "COMMAND" > $TMPFILE1
echo "PID" > $TMPFILE2
echo "NAME" > $TMPFILE3

for i in $pid; 
    do 
        count1=$(ls -l /proc/$i/fd 2>/dev/null | awk '{print $11}' | tail -n +2 | tee -a $TMPFILE3 | wc -l)
        count2=$(cat /proc/$i/maps 2> /dev/null | awk '{print $6}' | grep -v "^$\|^\[" | sort | uniq | tee -a $TMPFILE3 | wc -l)
        [ "$count1" -gt 0 ] && printf "$i\n%.0s" $(seq "$count1") >> $TMPFILE2 && printf "$(cat /proc/$i/status | grep -i "name" | awk '{print $2}')\n%.0s" $(seq "$count1") >> $TMPFILE1
        [ "$count2" -gt 0 ] && printf "$i\n%.0s" $(seq "$count2") >> $TMPFILE2 && printf "$(cat /proc/$i/status | grep -i "name" | awk '{print $2}')\n%.0s" $(seq "$count2") >> $TMPFILE1
    done

paste $TMPFILE1 $TMPFILE2 $TMPFILE3 

rm -f $TMPFILE{1..3}