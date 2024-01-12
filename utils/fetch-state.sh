#!/bin/bash

# Flags
EMPTY=false
while [ "$#" -gt 0 ]; do
  case $1 in
    --empty)
        EMPTY=true;
        shift
        ;;
    *) 
        shift
        ;;
  esac
done

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Fetch genesis.json or genesis-empty.json, depending on whether we are creating a local chain or public test chain.
if ! $EMPTY; then
    wget -qO "$CONFIG_DIR/genesis.json" $REPO_BASE_URL/genesis-parameters/main/$CHAIN_ID/genesis.json
else
    wget -qO "$CONFIG_DIR/genesis.json" $REPO_BASE_URL/genesis-parameters/main/$CHAIN_ID/genesis-empty.json
fi

# Echo result
echo "Added genesis.json file to $CONFIG_DIR"