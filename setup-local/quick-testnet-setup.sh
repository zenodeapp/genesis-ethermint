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
echo "This script should only be used if you intend on running a full-node for the GenesisL1 testnet."
echo "This will not take care of any backups! So make sure to do this if you have an existing .tgenesis"
echo "folder already. You can use utils/create-backup.sh for this."
echo ""
echo "WARNING: this script is intended for LOCAL testing and should NOT be used for public testnet purposes."
echo "Use setup/quick-testnet-setup.sh for this instead."
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
sh ./setup/dependencies.sh

# Building binaries
make install

# Set chain-id
$BINARY_NAME config chain-id $CHAIN_ID

# Remove current genesis.json if it exists
rm -f $CONFIG_DIR/genesis.json

# Init node
$BINARY_NAME init $MONIKER --chain-id $CHAIN_ID -o

# Chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel)
# - [p2p] addr_book_strict = false
# - [p2p] allow_duplicate_ip = true
# - [api] enabled = true
# - [api] enabled-unsafe-cors = true
cp "./configs/default_app_local.toml" $CONFIG_DIR/app.toml
cp "./configs/default_config_local.toml" $CONFIG_DIR/config.toml
# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$MONIKER\"/" $CONFIG_DIR/config.toml

# Shape our empty genesis.json file
# Replace "stake" with "el1"
sed -i 's/"stake"/"el1"/g' $CONFIG_DIR/genesis.json
# Replace "aphoton" with "el1"
sed -i 's/"aphoton"/"el1"/g' $CONFIG_DIR/genesis.json
# Change "max_deposit_period"
sed -i 's/"max_deposit_period": "[^"]*"/"max_deposit_period": "100s"/g' $CONFIG_DIR/genesis.json
# Change "voting_period"
sed -i 's/"voting_period": "[^"]*"/"voting_period": "100s"/g' $CONFIG_DIR/genesis.json
# Change "token_pair_voting_period"
sed -i 's/"token_pair_voting_period": "[^"]*"/"token_pair_voting_period": "100s"/g' $CONFIG_DIR/genesis.json
# Change "unbonding_time"
sed -i 's/"unbonding_time": "[^"]*"/"unbonding_time": "100s"/g' $CONFIG_DIR/genesis.json

# We don't fetch any peers when we setup a local chain

# Reset to imported genesis.json
$BINARY_NAME tendermint unsafe-reset-all

# Install service
sh ./utils/install-service.sh

# Echo result
echo ""
echo "Done!"
echo ""
echo "o If you haven't already created a key, use utils/create-key.sh or utils/import-key.sh to create or import a private key."
echo "o Follow this by running setup-local/create-validator.sh to add this key as a validator."
echo "o When ready, turn on your node using 'systemctl start $BINARY_NAME' and 'journalctl -fu $BINARY_NAME -ocat' to see the logs."