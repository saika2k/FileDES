#!/bin/bash

i=1

echo "start listen on port 10001"

nc -l -k -p 10001 | while read -r line; do
    tmp_file=$(mktemp)
    filename="verify_agg_${i}"
    echo "$line" > "$tmp_file"
    mv "$tmp_file" "$filename"
    echo "Result save to $filename"
    echo "Receive at: $(date '+%Y-%m-%d %H:%M:%S')"
    i=$((i+1))
    total=$((total+1))
    echo "Total received: $total"

done

