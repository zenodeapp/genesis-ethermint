#!/bin/bash

cat << "EOF"
This script will create your new genesisL1 validator.
You should run this script on fully synchronized node.
sh mainnet-node.sh
You can check status of your node service with:
service genesis status
This script should be running with arguments:
-YOUR_VALIDATOR_NAME
-YOUR_PRIVATE_KEY (please, use NEW keys to avoid issues!!!)
-AMOUNT_STAKED (in aphoton, 1aphoton = 1wei)
-COMISSION_RATE(0.01 = 1%; 0.99 = 99%)
Be ready to submit new password to encrypt your key and remember it. 

Example that will create validator named "supervalidator" with 1000L1 self stake and 10% comission:
sh create-validator.sh supervalidator 58a86862565e596bcf185d699ef4db6a8f02f6696f4a3fe6ff5cf5c0b451c866 1000000000000000000000 0.1
EOF

cd
cd go
cd bin

./evmosd keys unsafe-import-eth-key importedethkey $2 --keyring-backend os
echo Importing your Ethereum key 
sleep 3s
./evmosd tx staking create-validator \
  --amount=$3aphoton \
  --pubkey=$(evmosd tendermint show-validator) \
  --moniker="$1" \
  --chain-id=genesis_29-1 \
  --commission-rate="$4" \
  --commission-max-rate="0.99" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1000000" \
  --gas="2100000" \
  --from=importedethkey \
  --fees=4200000000000000aphoton \
  --broadcast-mode async \
  -y

