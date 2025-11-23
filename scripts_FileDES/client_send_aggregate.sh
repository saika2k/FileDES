#!/bin/bash

SERVER_IP=$1
AGG_NUM=$2
MY_IP=$3

for i in {1..10}; do # 打印当前进度和时间 
	{
		echo "$AGG_NUM"
		echo "$MY_IP"
	} | nc "$SERVER_IP" 10000 -q 1
	echo "[Msg $i/10] send finish"
	sleep 120 
done
