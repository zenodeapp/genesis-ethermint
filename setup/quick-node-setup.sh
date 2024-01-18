#!/bin/bash

# Arguments check
if [ -z "$1" ]; then
    echo ""
    echo "Usage: sh $0 <moniker>"
    echo ""
    exit 1
fi

cat <<"EOF"

  /$$$$$$                                          /$$                 /$$         /$$       
 /$$__  $$                                        |__/                | $$       /$$$$       
| $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$      | $$      |_  $$       
| $$ /$$$$ /$$__  $$| $$__  $$ /$$__  $$ /$$_____/| $$ /$$_____/      | $$        | $$       
| $$|_  $$| $$$$$$$$| $$  \ $$| $$$$$$$$|  $$$$$$ | $$|  $$$$$$       | $$        | $$       
| $$  \ $$| $$_____/| $$  | $$| $$_____/ \____  $$| $$ \____  $$      | $$        | $$       
|  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/| $$ /$$$$$$$/      | $$$$$$$$ /$$$$$$     
 \______/  \_______/|__/  |__/ \_______/|_______/ |__/|_______/       |________/|______/     

Welcome to the decentralized blockchain Renaissance, above money & beyond cryptocurrency!
EOF

echo ""
echo "This script should only be used if you intend on running a full-node for the GenesisL1 mainnet."
echo "This will not take care of any backups! So make sure to do this if you have an existing .tgenesis"
echo "folder already. You can use utils/backup/create.sh for this."
echo ""
echo "NOTE: if you prefer to use a wizard which will also guide you through the creation for a key,"
echo "backup, auto-start etc, then use node-setup-wizard.sh instead."
echo ""
read -p "Do you want to continue? (y/N): " ANSWER

ANSWER=$(echo "$ANSWER" | tr 'A-Z' 'a-z')  # Convert to lowercase

if [ "$ANSWER" != "y" ]; then
    echo "Aborted."
    exit 1
fi

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Arguments
MONIKER=$1

# Stop processes
systemctl stop $BINARY_NAME

# cd to root of the repository
cd $REPO_ROOT

# System update and installation of dependencies
. ./setup/dependencies.sh

# Building binaries
make install

# Set chain-id
$BINARY_NAME config chain-id $CHAIN_ID

# Init node
$BINARY_NAME init $MONIKER --chain-id $CHAIN_ID -o

# Chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel)
cp "./configs/default_app.toml" $CONFIG_DIR/app.toml
cp "./configs/default_config.toml" $CONFIG_DIR/config.toml
# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" $CONFIG_DIR/config.toml

# Fetch state file from genesis-parameters repo
sh ./utils/fetch/state.sh

# Fetch latest seeds and peers list from genesis-parameters repo
sh ./utils/fetch/peers.sh

# Reset to imported genesis.json
$BINARY_NAME tendermint unsafe-reset-all

# Install service
sh ./utils/service/install.sh

# Echo result
echo ""
echo "Done!"
echo ""
echo "If you haven't already created a key, use utils/key/create.sh or utils/key/import.sh to create or import a private key."
echo "When ready, turn on your node using 'systemctl start $BINARY_NAME' and 'journalctl -fu $BINARY_NAME -ocat' to see the logs."
