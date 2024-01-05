#!/bin/bash

#   /$$$$$$                                          /$$                 /$$         /$$       
#  /$$__  $$                                        |__/                | $$       /$$$$       
# | $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$      | $$      |_  $$       
# | $$ /$$$$ /$$__  $$| $$__  $$ /$$__  $$ /$$_____/| $$ /$$_____/      | $$        | $$       
# | $$|_  $$| $$$$$$$$| $$  \ $$| $$$$$$$$|  $$$$$$ | $$|  $$$$$$       | $$        | $$       
# | $$  \ $$| $$_____/| $$  | $$| $$_____/ \____  $$| $$ \____  $$      | $$        | $$       
# |  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/| $$ /$$$$$$$/      | $$$$$$$$ /$$$$$$     
#  \______/  \_______/|__/  |__/ \_______/|_______/ |__/|_______/       |________/|______/     
                                                                                             
# Welcome to the decentralized blockchain Renaissance, above money & beyond cryptocurrency!

# This script is intended for those who prefer to manually init their nodes and should more-
# so be read and adapted to your own setup in order for it to work.

# WARNING: This script does not create any backups whatsoever, make sure to create one if
# you go this route.

# Variables
MONIKER=${1:-mygenesismoniker} # $1 or defaults to mygenesismoniker
KEY=${2:-mygenesiskey} # $2 or defaults to mygenesiskey
CHAIN_ID=genesis_29-2
NODE_DIR=.genesis

# Stop processes
systemctl stop genesisd
pkill cosmovisor

# System update and installation of dependencies
sh dependencies.sh

# cd to root of the repository
cd ..

# Building genesisd binaries
make install

# Set chain-id
genesisd config chain-id $CHAIN_ID

# Create key
genesisd config keyring-backend os
genesisd keys add $KEY --keyring-backend os --algo eth_secp256k1

# Init node
genesisd init $MONIKER --chain-id $CHAIN_ID -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp "./configs/default_app.toml" ~/$NODE_DIR/config/app.toml
cp "./configs/default_config.toml" ~/$NODE_DIR/config/config.toml
cp ./states/$CHAIN_ID/genesis.json ~/$NODE_DIR/config/genesis.json
# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" ~/$NODE_DIR/config/config.toml

# Reset to imported genesis.json
genesisd tendermint unsafe-reset-all

# Add service
cp "./services/genesisd.service" /etc/systemd/system/genesisd.service
systemctl daemon-reload
systemctl enable genesisd

# Start node as service
systemctl start genesisd
