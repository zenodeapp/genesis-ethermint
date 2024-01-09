#!/bin/bash

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: sh $0 <MONIKER> <KEY>"
    exit 1
fi

# Arguments
MONIKER=$1
KEY=$2

$BINARY_NAME add-genesis-account $KEY "1100000000000000000000000el1"
$BINARY_NAME gentx $KEY "100000000000000000000000el1" --moniker $MONIKER --from $KEY --pubkey=$($BINARY_NAME tendermint show-validator) --commission-rate "0.05" --commission-max-rate "0.99" --commission-max-change-rate "0.10" --min-self-delegation "1000000" --chain-id $CHAIN_ID