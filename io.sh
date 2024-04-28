#!/bin/bash

run_process () {
    name=$1
    echo -e "\nProcess $name started at $(date +%H:%M:%S)\n" >> $name.txt
    ionice $3 $4 tar -xf "$2/archive.tar" -C "$2" >/dev/null
    echo "Process $name finished at $(date +%H:%M:%S)" >> $name.txt
} 

mkdir /root/dir1
mkdir /root/dir2
mkdir /root/dir1_2
mkdir /root/dir2_2
temp_dir1=/root/dir1
temp_dir2=/root/dir2
temp_dir3=/root/dir1_2
temp_dir4=/root/dir2_2

echo "Generating temporary files..."
for i in {1..100}; do
    dd if=/dev/zero of="$temp_dir1/file$i" bs=1M count=10 &>/dev/null
done
echo "Copying temporary files..."
cp $temp_dir1/* $temp_dir2

echo "Creating archives..."
tar -cf "$temp_dir3/archive.tar" -C "$temp_dir1" . >/dev/null
tar -cf "$temp_dir4/archive.tar" -C "$temp_dir2" . >/dev/null

echo "Starting both processes..."
(time run_process "HighPriority" "$temp_dir3" "-c1" "-n0") 2>> HighPriority.txt &

(time run_process "LowPriority" "$temp_dir4" "-c3") 2>> LowPriority.txt &

wait
echo -e "\nAll processes finished"
cat HighPriority.txt
cat LowPriority.txt
rm -rf HighPriority.txt LowPriority.txt "$temp_dir1" "$temp_dir2" "$temp_dir3" "$temp_dir4" 
