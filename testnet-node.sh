
#!/bin/bash
cat << "EOF"


	  /$$$$$$                                          /$$                 /$$         /$$
	 /$$__  $$                                        |__/                | $$       /$$$$
	| $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$      | $$      |_  $$
	| $$ /$$$$ /$$__  $$| $$__  $$ /$$__  $$ /$$_____/| $$ /$$_____/      | $$        | $$	
	| $$|_  $$| $$$$$$$$| $$  \ $$| $$$$$$$$|  $$$$$$ | $$|  $$$$$$       | $$        | $$
	| $$  \ $$| $$_____/| $$  | $$| $$_____/ \____  $$| $$ \____  $$      | $$        | $$
	|  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/| $$ /$$$$$$$/      | $$$$$$$$ /$$$$$$
	 \______/  \_______/|__/  |__/ \_______/|_______/ |__/|_______/       |________/|______/
	 
	 
	Welcome to the decentralized blockchain Renaissance, above money & beyond cryptocurrency!
	This script will setup and run your own Genesis L1 Testnet evmosd based node with geth RPC.
	NOTE: Be ready to enter and remember your NEW strong passwords during installation process.
	GENESIS L1 is a highly experimental decentralized project, provided AS IS, with no warranty.
          
  Testnet EVM chain ID: 26
  Mainnet EVM chain ID: 29
  Coin unit: L1
  Min. coin unit: aphoton
  Min. gas price: 1 aphoton
  1 L1 = 1 000 000 000 000 000 000 aphoton 	
  Initial supply: 21 000 000 L1
  Mint rate: < 20% annual
  Block target time: ~5s
  Binary name: evmosd
  
EOF
sleep 15s
sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd -y
snap install --channel=1.17/stable go --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

KEY="mygenesiskey"
CHAINID="genesis_26-1"
#MONIKER="nodeone"
KEYRING="os"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
#TRACE=""

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
evmosd init $1 --chain-id $CHAINID 

# Change parameter token denominations to aphoton
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="aphoton"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# block time (?)
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Set gas limit in genesis
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="100000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
fi

# Allocate genesis accounts (cosmos formatted addresses)
evmosd add-genesis-account $KEY 21000000000000000000000000aphoton --keyring-backend $KEYRING

# Sign genesis transaction
evmosd gentx $KEY 1000000000000000000aphoton --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
evmosd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
evmosd validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1aphoton --json-rpc.api eth,txpool,personal,net,web3 &
evmosd_pid=$!
sleep 10s
kill $evmosd_pid
echo Genesis L1 node stopped, adjusting to public testnetV2
sleep 5s
echo Starting some preparations before joining public network: adding peers, seeds, genesis.json and some LOVE!
cd
cd .evmosd/data
find -regextype posix-awk ! -regex './(priv_validator_state.json)' -print0 | xargs -0 rm -rf
cd ../config
sed -i 's/seeds = ""/seeds = "b98e61d8e3443bfc9b01910e767f004a72d94ed8@23.88.68.53:26656"/' config.toml
sed -i 's/persistent_peers = ""/persistent_peers = "b98e61d8e3443bfc9b01910e767f004a72d94ed8@23.88.68.53:26656"/' config.toml
rm -r genesis.json
wget https://raw.githubusercontent.com/alpha-omega-labs/bashscripts/main/testnetv2/genesis.json
cd
cd go/bin
echo All set! 
sleep 3s
cat << "EOF"

     	    \\
             \\_
          .---(')
        o( )_-\_
       Node start                                                                                                                                                                                     
EOF
 
sleep 5s
screen -d -m ./evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1000000000aphoton --json-rpc.api eth,txpool,net,web3,debug
echo Your Genesis L1 node started in screen, you may try *screen -r* command to see it! Welcome to Genesis L1 blockchain! 
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
sleep 5s
