#!/bin/bash

FILE=/home/adminuser/csv_log.csv
DATE=$(date +"%Y-%m-%d %H:%M:%S")

if [ ! -f $FILE ]; then
printf "Memory;Disk;CPU;Date\n" > $FILE
fi
end=$((SECONDS+1))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }' | tr -d ' \t\r\n')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}' | tr -d ' \t\r\n')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}' | tr -d ' \t\r\n')
echo "$MEMORY;$DISK;$CPU;$DATE" >> $FILE
sleep 1
done
