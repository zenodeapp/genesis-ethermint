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

# Stop processes
systemctl stop genesisd
pkill cosmovisor

# System update and installation of dependencies
sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd wget -y
snap install go --channel=1.20/stable --classic
snap refresh go --channel=1.20/stable --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

# Global change of open file limits
echo "* - nofile 50000" >> /etc/security/limits.conf
echo "root - nofile 50000" >> /etc/security/limits.conf
echo "fs.file-max = 50000" >> /etc/sysctl.conf 
ulimit -n 50000

# cd to root of the repository
cd ..

# Building genesisd binaries
make install

# Set chain-id
genesisd config chain-id genesis_29-2

# Create key
genesisd config keyring-backend os
genesisd keys add mygenesiskey --keyring-backend os --algo eth_secp256k1

# Init node
genesisd init mygenesismoniker --chain-id genesis_29-2 -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp "./configs/default_app.toml" ~/.genesis/config/app.toml
cp "./configs/default_config.toml" ~/.genesis/config/config.toml
cp ./states/genesis_29-2/genesis.json ~/.genesis/config/genesis.json
# Set moniker again since the configs got overwritten
sed -i "s/moniker = \"\"/moniker = \"mygenesismoniker\"/" ~/.genesis/config/config.toml

# Reset to imported genesis.json
genesisd tendermint unsafe-reset-all

# Add service
cp "./services/genesisd.service" /etc/systemd/system/genesisd.service
systemctl daemon-reload
systemctl enable genesisd

# Start node as service
systemctl start genesisd