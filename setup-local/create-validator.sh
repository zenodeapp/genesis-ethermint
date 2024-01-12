#!/bin/bash

# Arguments check
if [ -z "$1" ] || [ -z "$2" ]; then
    echo ""
    echo "Usage: sh $0 <moniker> <key_alias>"
    echo ""
    exit 1
fi

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Arguments
MONIKER=$1
KEY_ALIAS=$2

rm -rf $CONFIG_DIR/gentx # Remove gentxs folder in case it already exists
sh $REPO_ROOT/setup/genesis-validator.sh $MONIKER $KEY_ALIAS

# Collect genesis transactions
echo ""
echo "Collecting and applying all genesis transactions..."
$BINARY_NAME collect-gentxs

# Reset again for genesis.json has changed
$BINARY_NAME tendermint unsafe-reset-all