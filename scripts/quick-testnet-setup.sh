#!/bin/bash

# Variables
MONIKER=mygenesismoniker
KEY=mygenesiskey
CHAIN_ID=tgenesis_29-2
NODE_DIR=.tgenesis

# Stop processes
systemctl stop tgenesisd
pkill cosmovisor

# System update and installation of dependencies
sh dependencies.sh

# cd to root of the repository
cd ..

# Building tgenesisd binaries
make install

# Set chain-id
tgenesisd config chain-id $CHAIN_ID

# Create key
tgenesisd config keyring-backend os
tgenesisd keys add $KEY --keyring-backend os --algo eth_secp256k1

# Init node
tgenesisd init $MONIKER --chain-id $CHAIN_ID -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp ./states/$CHAIN_ID/genesis.json ~/$NODE_DIR/config/genesis.json

# For public configs
cp ./configs/default_app.toml ~/$NODE_DIR/config/app.toml
cp ./configs/default_config.toml ~/$NODE_DIR/config/config.toml

# For local configs (addr_book_strict is set to false and allow_duplicate_ip to true)
# cp ./configs/default_app_local.toml ~/$NODE_DIR/config/app.toml
# cp ./configs/default_config_local.toml ~/$NODE_DIR/config/config.toml

# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" ~/$NODE_DIR/config/config.toml

# Reset to imported genesis.json
tgenesisd tendermint unsafe-reset-all

# Add service
cp ./services/tgenesisd.service /etc/systemd/system/tgenesisd.service
systemctl daemon-reload
systemctl enable tgenesisd

# Start node as service
systemctl start tgenesisd