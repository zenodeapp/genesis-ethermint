
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
	This script will update genesis_29-1 to genesis_29-2.
	NOTE: Be ready to enter and remember your NEW strong passwords during the installation process.
	GENESIS L1 is a highly experimental decentralized project, provided AS IS, with NO WARRANTY.
	GENESIS L1 IS A NON COMMERCIAL OPEN DECENRALIZED BLOCKCHAIN PROJECT RELATED TO SCIENCE AND ART
          
  Mainnet EVM chain ID: 29
  Cosmos chain ID: genesis_29-2
  Blockchain utilitarian coin: L1
  Min. coin unit: el1
  1 L1 = 1 000 000 000 000 000 000 el1 	
  Initial supply: 21 000 000 L1
  Mint rate: < 20% annual
  Block target time: ~5s
  Binary name: genesisd
  
EOF
sleep 15s

# SYSTEM UPDATE, INSTALLATION OF THE FOLLOWING PACKAGES: jq git wget make gcc build-essential snapd wget, INSTALLATION OF GO 1.17 via snap

sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd wget -y
snap install --channel=1.17/stable go --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

# SETTINGS

KEY="mygenesiskey"
CHAINID="genesis_29-2"
#MONIKER="nodeone"
KEYRING="os"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
TRACE="--trace"
#TRACE=""

# GLOBAL CHANGE OF OPEN FILE LIMITS

echo "* - nofile 50000" >> /etc/security/limits.conf
echo "root - nofile 50000" >> /etc/security/limits.conf
echo "fs.file-max = 50000" >> /etc/sysctl.conf 
ulimit -n 50000

# DELETING OF .genesisd FOLDER (PREVIOUS INSTALLATIONS)
cd 
rm -r .genesisd

# BUILDING genesisd BINARIES

cd genesisL1
make install

# SETTING UP THE keyring type and chain-id in CONFIG
genesisd config keyring-backend $KEYRING
genesisd config chain-id $CHAINID

# CREATION OF THE NEW KEY NAMED mygenesiskey
genesisd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# SETTING THE NODE NAME (MONIKER) AND INITIATION OF THE NEW LOCAL GENESISL1 BLOCKCHAIN 
genesisd init $1 --chain-id $CHAINID 

# ALLOCATION OF 21ML1 IN LOCAL GENESISL1 BLOCKCHAIN TO mygenesiskey
genesisd add-genesis-account $KEY 21000000000000000000000000el1 --keyring-backend $KEYRING

# SIGN THE GENTX
genesisd gentx $KEY 1000000000000000000el1 --keyring-backend $KEYRING --chain-id $CHAINID

# COLLECT THE GENTX
genesisd collect-gentxs

# VALIDATE LOCAL genesis.json
genesisd validate-genesis

# START GENESISL1 LOCALNODE
genesisd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1el1 --json-rpc.api eth,txpool,personal,net,web3 &
genesisd_pid=$!

# LET IT WORK FOR 10S AND STOP IT TO ADJUST TO THE PUBLIC MAINNET 
sleep 10s
kill $genesisd_pid
echo Genesis L1 node stopped, adjusting to public mainnet
sleep 5s
echo Starting some preparations before joining public network: adding peers, seeds, genesis.json and some LOVE!
cd
cd .genesisd/data
find -regextype posix-awk ! -regex './(priv_validator_state.json)' -print0 | xargs -0 rm -rf
cd ../config
sed -i 's/seeds = ""/seeds = "212b792bd68518c6f919216b796d102297480c80@172.105.67.67:26656"/' config.toml
sed -i 's/persistent_peers = "212b792bd68518c6f919216b796d102297480c80@172.105.67.67:26656"/' config.toml

# REMOVING genesis.json, IMPORTING genesis_29-1 STATE
rm -r genesis.json
wget https://raw.githubusercontent.com/alpha-omega-labs/noobdate/main/genesis_noobdate_test_state.json
mv genesis_noobdate_test_state.json genesis.json
cd

# COPY WITH REWRITE OF .evmosd FOLDER OF OLD NODE (VALIDATOR) TO .genesisd OF NEW NODE (VALIDATOR)

# STARTING GENESIS L1 V2 NODE
genesisd start --chain-id genesis_29-2 --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=1el1
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
