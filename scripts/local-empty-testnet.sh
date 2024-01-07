#!/bin/bash

# WARNING: THIS WILL WIPE A PREVIOUS .tgenesis installation.

# Variables
MONIKER=${1:-mygenesismoniker} # $1 or defaults to mygenesismoniker
KEY=${2:-mygenesiskey} # $2 or defaults to mygenesiskey
CHAIN_ID=tgenesis_29-2
NODE_DIR=.tgenesis
REPO_DIR=$(cd "$(dirname "$0")"/.. && pwd)
SCRIPTS_DIR=$REPO_DIR/scripts

# Stop processes
systemctl stop tgenesisd
pkill cosmovisor

# Remove the previous installation
rm -rf ~/.tgenesis

# System update and installation of dependencies
sh $SCRIPTS_DIR/dependencies.sh

# cd to root of the repository
cd $REPO_DIR

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
cp ./states/$CHAIN_ID/genesis-empty.json ~/$NODE_DIR/config/genesis.json
# For local configs (addr_book_strict is set to false and allow_duplicate_ip to true)
cp ./configs/default_app_local.toml ~/$NODE_DIR/config/app.toml
cp ./configs/default_config_local.toml ~/$NODE_DIR/config/config.toml

# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" ~/$NODE_DIR/config/config.toml

sh $SCRIPTS_DIR/generate-validator.sh $MONIKER $KEY
sh $SCRIPTS_DIR/collect-gentxs.sh

# Reset to imported genesis.json
tgenesisd tendermint unsafe-reset-all

# Add service
cp ./services/tgenesisd.service /etc/systemd/system/tgenesisd.service
systemctl daemon-reload
systemctl enable tgenesisd

# Start node as service
systemctl start tgenesisd

# Open log
journalctl -fu tgenesisd -ocat
