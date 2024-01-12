#!/bin/bash

# Arguments check
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: sh $0 <moniker> <key_alias>"
    exit 1
fi

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Arguments
MONIKER=$1
KEY_ALIAS=$2

echo ""

# Create genesis account with provided key
echo "Confirm the creation of genesis account: $KEY_ALIAS..."
$BINARY_NAME add-genesis-account $KEY_ALIAS "1100000000000000000000000el1"

echo ""

# Generate transaction for adding a genesis validator
echo "Confirm generating a genesis transaction for validator $MONIKER..."
$BINARY_NAME gentx $KEY_ALIAS "100000000000000000000000el1" --moniker $MONIKER --from $KEY_ALIAS \
--pubkey=$($BINARY_NAME tendermint show-validator) --commission-rate "0.05" --commission-max-rate "0.99" \
--commission-max-change-rate "0.10" --min-self-delegation "1000000" --chain-id $CHAIN_ID