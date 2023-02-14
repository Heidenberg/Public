#!/bin/bash

FILE=csv_log.csv

printf "Memory\t\tDisk\t\tCPU\n"
end=$((SECONDS+1))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }');
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}');
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}');
echo "$MEMORY$DISK$CPU" > $FILE
sleep 1