#!/bin/bash

# Arguments check
if [ -z "$1" ] || [ -z "$2" ]; then
    echo ""
    echo "Usage: sh $0 <key_alias> <upgrade_height> [next_proposal_id]"
    echo "       - [next_proposal_id] is optional, but should point towards the upgrade proposal to vote yes on (default: 1)"
    echo ""
    exit 1
fi

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Arguments
KEY_ALIAS=$1
UPGRADE_HEIGHT=$2
NEXT_PROPOSAL_ID=${3:-1}

echo ""

# Submit software-upgrade proposal for plan_crypto
echo "Submit a software-upgrade proposal for plan_crypto..."
$BINARY_NAME tx gov submit-proposal software-upgrade "plan_crypto" --upgrade-height $UPGRADE_HEIGHT \
--from $KEY_ALIAS --title "Hardfork to Cronos" --description "Hardfork to Cronos" --deposit "10000000000000000000000el1" \
--fees "10000000000000000el1" -y

echo ""

# Vote on the proposal
echo "Vote yes on proposal $NEXT_PROPOSAL_ID..."
$BINARY_NAME tx gov vote $NEXT_PROPOSAL_ID yes --from $KEY_ALIAS --fees "10000000000000000el1" -y
