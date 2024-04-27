#!/bin/bash

TMPFILE1=$(mktemp)
TMPFILE2=$(mktemp)
TMPFILE3=$(mktemp)

echo "PID" > $TMPFILE1
echo "STAT          " > $TMPFILE2
echo "NAME" > $TMPFILE3

cat /proc/[0-9]*/status | grep -i "^pid" | awk '{print $2}' >> $TMPFILE1
cat /proc/[0-9]*/status | grep -i "^state" | awk '{print $2, $3}' >> $TMPFILE2
cat /proc/[0-9]*/status | grep -i "name" | awk '{print $2}' >> $TMPFILE3

paste $TMPFILE1 $TMPFILE2 $TMPFILE3 | sort -g
rm -f $TMPFILE{1..3}