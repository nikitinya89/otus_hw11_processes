#!/bin/bash
run_process () {
    name=$1
    echo -e "\nProcess $name started at $(date +%H:%M:%S)\n" >> $name.txt
    nice -n $2 dd if=/dev/urandom of=/dev/null bs=4096 count=100000 2> /dev/null
    echo "Process $name finished at $(date +%H:%M:%S)" >> $name.txt
} 

echo "High Priority Process started"
(time run_process HighPriority "-20") 2>> HighPriority.txt &
echo "Low Priority Process started"
(time run_process LowPriority "19") 2>> LowPriority.txt &

wait
echo -e "\nAll processes finished"
cat HighPriority.txt
cat LowPriority.txt
rm HighPriority.txt
rm LowPriority.txt