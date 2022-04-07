
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
	This script will setup and run your own Genesis L1 MainNet node with geth RPC.
	NOTE: Be ready to enter and remember your NEW strong passwords during installation process.
	GENESIS L1 is a highly experimental decentralized project, provided AS IS, with NO WARRANTY.
	GENESIS L1 IS A NON COMMERCIAL OPEN DECENRALIZED BLOCKCHAIN PROJECT RELATED TO SCIENCE AND ART.
          
  Mainnet EVM chain ID: 29
  Cosmos chain ID: genesis_29-2
  Blockchain utilitarian coin: L1
  Min. unit: el1
  1 L1 = 1 000 000 000 000 000 000 EL1 	
  Initial supply: 21 000 000 L1
  Mint rate: < 20% annual
  Block target time: ~5s
  Binary name: genesisd
  
EOF
sleep 15s
sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd wget -y
snap install --channel=1.17/stable go --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

KEY="mygenesiskey"
CHAINID="genesis_29-2"
#MONIKER="nodeone"
KEYRING="os"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
#TRACE=""

#global change of open files limits
echo "* - nofile 50000" >> /etc/security/limits.conf
echo "root - nofile 50000" >> /etc/security/limits.conf
echo "fs.file-max = 50000" >> /etc/sysctl.conf 
ulimit -n 50000

make install
genesisd config keyring-backend $KEYRING
genesisd config chain-id $CHAINID

# if $KEY exists it should be deleted
genesisd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
genesisd init $1 --chain-id $CHAINID 

# Allocate genesis accounts (cosmos formatted addresses)
genesisd add-genesis-account $KEY 21000000000000000000000000el1 --keyring-backend $KEYRING

# Sign genesis transaction
genesisd gentx $KEY 1000000000000000000el1 --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
genesisd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
genesisd validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
genesisd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1el1 --json-rpc.api eth,txpool,personal,net,web3 &
genesisd_pid=$!
sleep 10s
kill $genesisd_pid
echo Genesis L1 node stopped, adjusting to public mainnet
sleep 5s
echo Starting some preparations before joining public network: adding peers, seeds, genesis.json and some LOVE!
cd
cd .genesisd/data
find -regextype posix-awk ! -regex './(priv_validator_state.json)' -print0 | xargs -0 rm -rf
cd ../config
sed -i 's/seeds = ""/seeds = ""/' config.toml
sed -i 's/persistent_peers = ""/' config.toml
rm -r genesis.json
wget https://raw.githubusercontent.com/alpha-omega-labs/noobdate/main/genesis_noobdate_test_state.json
mv genesis_noobdate_test_state.json genesis.json
cd
genesisd start --chain-id genesis_29-2
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
