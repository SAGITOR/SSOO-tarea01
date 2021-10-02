#!/bin/bash
chmod +x ejemplo.sh
count=1
echo Nombre del archivo: $0
for i in $@; do echo argumento $count: $i;((count++));done
echo PDI: $$
cat /proc/$$/status | head
