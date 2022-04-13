
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


	 /$$   /$$ /$$$$$$$$  /$$$$$$  /$$       /$$$$$$ /$$$$$$$$ /$$   /$$ /$$$$$$  /$$$$$$ 
	| $$$ | $$| $$_____/ /$$__  $$| $$      |_  $$_/|__  $$__/| $$  | $$|_  $$_/ /$$__  $$
	| $$$$| $$| $$      | $$  \ $$| $$        | $$     | $$   | $$  | $$  | $$  | $$  \__/
	| $$ $$ $$| $$$$$   | $$  | $$| $$        | $$     | $$   | $$$$$$$$  | $$  | $$      
	| $$  $$$$| $$__/   | $$  | $$| $$        | $$     | $$   | $$__  $$  | $$  | $$      
	| $$\  $$$| $$      | $$  | $$| $$        | $$     | $$   | $$  | $$  | $$  | $$    $$
	| $$ \  $$| $$$$$$$$|  $$$$$$/| $$$$$$$$ /$$$$$$   | $$   | $$  | $$ /$$$$$$|  $$$$$$/
	|__/  \__/|________/ \______/ |________/|______/   |__/   |__/  |__/|______/ \______/ 
                                                                                                                                                                       
                                                                                      	 
	 /$$   /$$  /$$$$$$   /$$$$$$  /$$$$$$$  /$$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$$$
	| $$$ | $$ /$$__  $$ /$$__  $$| $$__  $$| $$__  $$ /$$__  $$|__  $$__/| $$_____/	
	| $$$$| $$| $$  \ $$| $$  \ $$| $$  \ $$| $$  \ $$| $$  \ $$   | $$   | $$      
	| $$ $$ $$| $$  | $$| $$  | $$| $$$$$$$ | $$  | $$| $$$$$$$$   | $$   | $$$$$   
	| $$  $$$$| $$  | $$| $$  | $$| $$__  $$| $$  | $$| $$__  $$   | $$   | $$__/   
	| $$\  $$$| $$  | $$| $$  | $$| $$  \ $$| $$  | $$| $$  | $$   | $$   | $$      
	| $$ \  $$|  $$$$$$/|  $$$$$$/| $$$$$$$/| $$$$$$$/| $$  | $$   | $$   | $$$$$$$$
	|__/  \__/ \______/  \______/ |_______/ |_______/ |__/  |__/   |__/   |________/
                                                                                                                                                            
                                                                                                                                                                                                                             	 
	Welcome to the decentralized blockchain Renaissance, above money & beyond cryptocurrency!
	This script should update genesis_29-1 to genesis_29-2 while running under root user.
	GENESIS L1 is a highly experimental decentralized project, provided AS IS, with NO WARRANTY.
	GENESIS L1 IS A NON COMMERCIAL OPEN DECENRALIZED BLOCKCHAIN PROJECT RELATED TO SCIENCE AND ART
          
  Mainnet EVM chain ID: 29
  Cosmos chain ID: genesis_29-2
  Blockchain utilitarian coin: L1
  Min. coin unit: el1
  1 L1 = 1 000 000 000 000 000 000 el1 	
  Initial supply: 21 000 000 L1
  genesis_29-2 circulation: ~22 000 000 L1
  Mint rate: < 20% annual
  Block target time: ~5s
  Binary name: genesisd
  genesis_29-1 start: Nov 30, 2021
EOF
sleep 15s


# SYSTEM UPDATE, INSTALLATION OF THE FOLLOWING PACKAGES: jq git wget make gcc build-essential snapd wget, INSTALLATION OF GO 1.17 via snap

sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd cmatrix sl wget -y
snap install --channel=1.17/stable go --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

# GLOBAL CHANGE OF OPEN FILE LIMITS
echo "* - nofile 50000" >> /etc/security/limits.conf
echo "root - nofile 50000" >> /etc/security/limits.conf
echo "fs.file-max = 50000" >> /etc/sysctl.conf 
ulimit -n 50000

#STOPPING EVMOSD DAEMON AND COSMOVISOR IF IT WAS NOT STOPPED
pkill evmosd
pkill cosmovisor

# BACKUP genesis_29-1 .evmosd
cd
rsync -r --verbose --exclude 'data' ./.evmosd/ ./.evmosd_backup/

# DELETING OF .genesisd FOLDER (PREVIOUS INSTALLATIONS)
cd 
rm -r .genesisd

# BUILDING genesisd BINARIES
cd genesisd
make install

# COPY .evmosd FILES to .genesisd FILES
cd
rsync -r --verbose --exclude 'data' ./.evmosd/ ./.genesisd/

# SETTING UP THE keyring type and chain-id in CONFIG
genesisd config chain-id genesis_29-2

#IMPORTING GENESIS STATE AND VALIDATION
cd 
cd .genesisd/config
rm -r genesis.json
wget https://raw.githubusercontent.com/alpha-omega-labs/noobdate/main/genesis_noobdate_test_state.json
mv genesis_noobdate_test_state.json genesis.json
cd
genesisd validate-genesis

# RESET TO IMPORTED genesis.json
genesisd unsafe-reset-all

# STARTING genesisd AS A SERVICE
cd
cd /etc/systemd/system
wget https://raw.githubusercontent.com/alpha-omega-labs/genesis/release/v0.3.x/genesisd.service
systemctl daemon-reload
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
service genesisd start
echo Your genesisL1 node service started, you may try *service genesisd status* command to see it! Welcome to genesisL1 blockchain! Give it some time to sync! 

