if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: sh $0 <MONIKER> <KEY>"
    exit 1
fi

MONIKER=$1
KEY=$2
CHAIN_ID=tgenesis_29-2

tgenesisd add-genesis-account $KEY "10000000000000000000000tel1"
tgenesisd gentx $KEY "10000000000000000000000tel1" --moniker $MONIKER --from $KEY --pubkey=$(tgenesisd tendermint show-validator) --commission-rate "0.05" --commission-max-rate "0.99" --commission-max-change-rate "0.10" --min-self-delegation "1000000" --chain-id $CHAIN_ID