#!/bin/bash

echo "start listen on port 10000"

nc -l -k -p 10000 | while read -r aggnum; do
    read -r myip

    echo "$aggnum"
    echo "$myip"

    echo "$aggnum" > paths/aggregate_number
    echo "$myip" >> paths/aggregate_number

    echo "parameters save to paths/aggregate_number"
    echo "Received at: $(date '+%Y-%m-%d %H:%M:%S')"
done

