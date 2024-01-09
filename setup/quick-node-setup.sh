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

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Arguments
MONIKER=${1:-mygenesismoniker} # $1 or defaults to mygenesismoniker
KEY=${2:-mygenesiskey} # $2 or defaults to mygenesiskey

# Stop processes
systemctl stop $BINARY_NAME
pkill cosmovisor

# cd to root of the repository
cd $REPO_ROOT

# System update and installation of dependencies
sh ./setup/dependencies.sh

# Building binaries
make install

# Set chain-id
$BINARY_NAME config chain-id $CHAIN_ID

# Create key
$BINARY_NAME config keyring-backend os
$BINARY_NAME keys add $KEY --keyring-backend os --algo eth_secp256k1

# Init node
$BINARY_NAME init $MONIKER --chain-id $CHAIN_ID -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp "./configs/default_app.toml" $CONFIG_DIR/app.toml
cp "./configs/default_config.toml" $CONFIG_DIR/config.toml
# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" $CONFIG_DIR/config.toml

# Fetch state file from genesis-parameters repo
sh ./utils/fetch-state.sh

# Fetch latest seeds and peers list from genesis-parameters repo
sh ./utils/fetch-peers.sh

# Reset to imported genesis.json
$BINARY_NAME tendermint unsafe-reset-all

# Install service
sh ./utils/install-service.sh

# Start node as service
systemctl start $BINARY_NAME
