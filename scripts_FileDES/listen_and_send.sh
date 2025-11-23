#!/bin/bash

total=0

echo "start listen on port 9999"

nc -l -k -p 9999 | while read -r addr; do 
	echo "receive address: $addr"
	echo "./lotus send "$addr" 10000000"
	./lotus send "$addr" 10000000
	total=$((total+1))
	echo "total send: $total"
done
