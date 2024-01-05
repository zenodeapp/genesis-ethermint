#!/bin/bash

# Fixed/default variables (do not modify)
chain_id="tgenesis_29-2"
node_dir=".tgenesis"
repo_dir=$(cd "$(dirname "$0")"/.. && pwd)
backup_dir=".tgenesis_backup_$(date +"%Y%m%d%H%M%S")"
moniker=""
key=""
local_network=false

if [ "$#" -lt 2 ]; then
    echo "Usage: sh $0 \e[3m--moniker string\e[0m \e[3m--key string\e[0m \e[3m[...options]\e[0m"
    echo ""
    echo "   Options:"
    echo "     \e[3m--local-network\e[0m          This allows multiple connections from the same IP and no strict addrbook (default: false)."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as the root user."
    exit 1
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
        --moniker)
            shift
            if [ -z "$1" ] || [ "$(echo "$1" | cut -c 1)" = "-" ]; then
                echo "Error: --moniker option requires a non-empty value."
                exit 1
            fi
            moniker="$1"
            ;;
        --key)
            shift
            if [ -z "$1" ] || [ "$(echo "$1" | cut -c 1)" = "-" ]; then
                echo "Error: --key option requires a non-empty value."
                exit 1
            fi
            key="$1"
            ;;
        --local-network)
            local_network=true
            ;;
        *)
            echo "Error: Unknown option $1"
            exit 1
            ;;
    esac
    shift
done

# Check if required options are provided
if [ -z "$moniker" ]; then
    echo "Error: --moniker is required."
    exit 1
fi

if [ -z "$key" ]; then
    echo "Error: --key is required."
    exit 1
fi

echo "Script configurations:"
echo " o Moniker will be set to: $moniker."
echo " o Will create a key with the alias: $key."

echo ""
echo "Please note the following:"
echo " - If a Cosmovisor process is running, it will be killed."
echo " - If the Genesis Testnet Daemon is running, it will be halted."
echo " - Existing app.toml and config.toml files will get overwritten!"
echo " - Any existing Genesis Testnet database will get wiped!"
echo ""

read -p "Do you still wish to continue? (y/N): " answer
answer=$(echo "$answer" | tr 'A-Z' 'a-z')  # Convert to lowercase

if [ "$answer" != "y" ]; then
  echo "Aborted."
  exit 1
fi

echo "Continuing..."

# Stop processes
systemctl stop tgenesisd
pkill cosmovisor

# System update and installation of dependencies
sh dependencies.sh

# cd to root of the repository
cd $repo_dir

# Building tgenesisd binaries
make install

# Set chain-id
tgenesisd config chain-id $chain_id

# Create key
tgenesisd config keyring-backend os
tgenesisd keys add $key --keyring-backend os --algo eth_secp256k1

# Check if the exit status of the previous command is equal to zero (zero means it succeeded, anything else means it failed)
if [ $? -eq 0 ]; then
  echo "Press Enter to continue..."
  read REPLY
fi

# Init node
tgenesisd init $moniker --chain-id $chain_id -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp $repo_dir/states/$chain_id/genesis.json ~/$node_dir/config/genesis.json

if $local_network; then
  cp $repo_dir/configs/default_app_local.toml ~/$node_dir/config/app.toml
  cp $repo_dir/configs/default_config_local.toml ~/$node_dir/config/config.toml
else
  cp $repo_dir/configs/default_app.toml ~/$node_dir/config/app.toml
  cp $repo_dir/configs/default_config.toml ~/$node_dir/config/config.toml
fi

# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$moniker\"/" ~/$node_dir/config/config.toml

# Reset to imported genesis.json
tgenesisd tendermint unsafe-reset-all

cp "$repo_dir/services/tgenesisd.service" /etc/systemd/system/tgenesisd.service
systemctl daemon-reload