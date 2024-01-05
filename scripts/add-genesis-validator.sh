if [ "$#" -lt 2 ]; then
    echo "Usage: sh $0 \e[3mmoniker\e[0m \e[3mkey\e[0m"
    exit 1
fi

tgenesisd add-genesis-account $2 "10000000000000000000000tel1"
tgenesisd gentx $2 "10000000000000000000000tel1" --moniker $1 --from $2 --pubkey=$(tgenesisd tendermint show-validator) --commission-rate "0.05" --commission-max-rate "0.99" --commission-max-change-rate "0.10" --min-self-delegation "1000000" --chain-id tgenesis_29-2
# tgenesisd collect-gentxs

# Reset to imported genesis.json
# tgenesisd tendermint unsafe-reset-all