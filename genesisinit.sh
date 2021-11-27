
KEY="adaovalidatorkey"
CHAINID="genesis_29-1"
MONIKER="adaovalidator"
KEYRING="os"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
#TRACE=""

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

#global change of open files limits
echo "* - nofile 500000" >> /etc/security/limits.conf
echo "root - nofile 500000" >> /etc/security/limits.conf
echo "fs.file-max = 500000" >> /etc/sysctl.conf 
ulimit -n 500000
# remove existing daemon
rm -rf ~/.evmosd*

make install

evmosd config keyring-backend $KEYRING
evmosd config chain-id $CHAINID

# if $KEY exists it should be deleted
evmosd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
evmosd init $MONIKER --chain-id $CHAINID 

# Change consensus_params
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["consensus_params"]["block"]["max_bytes"]="1048576"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

cat $HOME/.evmosd/config/genesis.json | jq '.app_state["consensus_params"]["evidence"]["max_age_num_blocks"]="403200"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["consensus_params"]["evidence"]["max_age_duration"]="2419200000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["consensus_params"]["evidence"]["max_bytes"]="150000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json



# Change parameter token denominations to aphoton
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["mint"]["minter"]["inflation"]="0.150000000000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json0

cat $HOME/.evmosd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["amount"]="300000000000000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# initial mint inflation rate set to 15%, minimal to 5%.
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["mint"]["params"]["inflation_rate_change"]="0.150000000000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["mint"]["params"]["inflation_min"]="0.050000000000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# block time (~5-7s)
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Set gas limit in genesisl1 = 100K
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="100000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Set unbound time to 3 days
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["staking"]["params"]["unbonding_time"]="259200s"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# 300 Spartans 
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["staking"]["params"]["max_validators"]=300' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json


# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
fi

if [[ $1 == "pending" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.evmosd/config/config.toml
  else
      sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.evmosd/config/config.toml
  fi
fi

# Allocate genesis accounts (cosmos formatted addresses)
evmosd add-genesis-account $KEY 21000000000000000000000000aphoton --keyring-backend $KEYRING

# Sign genesis transaction with Genesis L1 DAO validator A: adaovalidator
evmosd gentx $KEY 300000000000000000000000aphoton --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
evmosd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
evmosd validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1000000000aphoton
