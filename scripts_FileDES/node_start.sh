#!/bin/bash

rm -rf localnet.json
rm -rf ~/.genesis-sectors
rm -rf ~/.lotus
rm -rf ~/.lotusminer
rm -rf DB
rm -rf SST
rm -rf client_upload
rm -rf client_download
rm -rf sealed 
rm -rf unseal
rm -rf acc
rm -rf leaf
rm -rf paths
rm -rf zk_output
rm lotus.log
rm miner.log
rm aggregate.log
mkdir paths
mkdir zk_output
mkdir unseal
mkdir sealed

DAEMON=$1
MINER=$2
IP=$3


nohup ./lotus daemon --genesis=devgen.car > lotus.log 2>&1 &

echo "sleep 30"
sleep 30

echo "./lotus net connect "$DAEMON""
./lotus net connect "$DAEMON"
echo "./lotus net connect "$MINER""
./lotus net connect "$MINER"


addr=$(./lotus wallet new bls)

echo "$addr"
echo "$addr" | nc -q 0 "$IP" 9999

echo "sleep 180"
sleep 180

./lotus wallet list

echo "./lotus-miner init --owner "$addr" --worker "$addr" --no-local-storage --sector-size=8MiB"

./lotus-miner init --owner "$addr" --worker "$addr" --no-local-storage --sector-size=8MiB

echo "sleep 10"
sleep 10 

nohup ./lotus-miner run > miner.log 2>&1 &

echo "init miner and sleep 60"
sleep 60

./lotus-miner info

./lotus-miner storage attach --init --store unseal
./lotus-miner storage attach --init --seal sealed

echo "./lotus-miner net connect "$DAEMON""
./lotus-miner net connect "$DAEMON"
echo "./lotus-miner net connect "$MINER""
./lotus-miner net connect "$MINER"

sleep 3
./lotus-miner net listen
sleep 3
./lotus-miner info

nohup bash scripts_FileDES/client_listen_aggregate.sh > aggregate.log 2>&1 &


#./lotus client import 7.5M


