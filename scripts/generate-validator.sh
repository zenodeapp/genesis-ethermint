# tgenesisd add-genesis-account $key "21000000000000000000000000tel1"
tgenesisd gentx $key "10000000000000000000000tel1" --moniker $moniker --from $key --pubkey=$(tgenesisd tendermint show-validator) --commission-rate "0.05" --commission-max-rate "0.99" --commission-max-change-rate "0.10" --min-self-delegation "1000000" --chain-id $chain_id
tgenesisd collect-gentxs

# Reset to imported genesis.json
tgenesisd tendermint unsafe-reset-all