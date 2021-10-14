#!/bin/bash

while [[ true ]]; do
	num=$(cat source.txt | wc -l)
	for (( i = 1; i < $num+2; i++ )); do
		host=$(sed "${i}q;d" source.txt | awk -F":" '{print $1}')
		port=$(sed "${i}q;d" source.txt | awk -F":" '{print $2}')
		output=$(netcat -zv $host $port 2>&1 | grep .)
		if [[ "$output" == *"open"* ]]; then
			echo "$host $port [OK]"
		else
			curl -X POST http://example.com -d "{'failed': '$host:$port'}"
		fi
	done
	sleep 60
done