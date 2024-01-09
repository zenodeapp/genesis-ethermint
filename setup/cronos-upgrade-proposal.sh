#!/bin/bash

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: sh $0 <KEY> <UPGRADE_HEIGHT> [NEXT_PROPOSAL_ID]"
    echo " - [NEXT_PROPOSAL_ID] defaults to 1"
    exit 1
fi

KEY=$1
UPGRADE_HEIGHT=$2
NEXT_PROPOSAL_ID=${3:-1}

$BINARY_NAME tx gov submit-proposal software-upgrade plan_cronos --upgrade-height $UPGRADE_HEIGHT --from $KEY --title "Hardfork to cronos" --description "Hardfork to cronos" --deposit "10000000000000000000000el1" --fees "10000000000000000el1" -y
$BINARY_NAME tx gov vote $NEXT_PROPOSAL_ID yes --from $KEY --fees "10000000000000000el1" -y