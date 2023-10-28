
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
	This script should reupdate genesis_29-2 to genesis_29-2 while running under root user.
	GENESIS L1 is a highly experimental decentralized project, provided AS IS, with NO WARRANTY.
	GENESIS L1 IS A NON COMMERCIAL OPEN DECENRALIZED BLOCKCHAIN PROJECT RELATED TO SCIENCE AND ART.
EOF
sleep 5s

sudo apt install sl
sl -F

# SYSTEM UPDATE, INSTALLATION OF THE FOLLOWING PACKAGES: jq git wget make gcc build-essential snapd wget ponysay, INSTALLATION OF GO 1.17 via snap

sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd wget curl lz4 tar -y
snap install --channel=1.20/stable go --classic
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc

# GLOBAL CHANGE OF OPEN FILE LIMITS
echo "* - nofile 50000" >> /etc/security/limits.conf
echo "root - nofile 50000" >> /etc/security/limits.conf
echo "fs.file-max = 50000" >> /etc/sysctl.conf 
ulimit -n 50000

#PONYSAY 
snap install ponysay
ponysay "Installing genesisd from source code with updated genesis_29-2 mainnet!"
sleep 5s
ponysay "WARNING: cosmosvisor, evmosd processes will be killed and genesis, genesisd, evmos, evmosd system services will be stopped with this script on the next step. If you have other blockchains running, you might want to delete those parts of the script!"
sleep 20s

# STOPPING EVMOSD DAEMON AND COSMOVISOR IF IT WAS NOT STOPPED
pkill evmosd
pkill cosmovisor
service genesis stop
service genesisd stop
service evmos stop
service evmosd stop

# AFTER STOPPING OF DAEMONS REMOVE ALL SWAP FILES MADE BY THE 0.46 UPGRADE
files_to_remove=$(find / -maxdepth 1 -type f -name 'genesisd_swapfile*')
if [ -z "$files_to_remove" ]; then
    echo "No swap files starting with '/genesisd_swapfile' found in the root directory."
else
    for file in $files_to_remove; do
        swapoff -v "$file"

        if swapon --show | grep -q "^$file "; then
            echo "Swap file $file was not removed because it is still in use."
        else
            rm -f "$file"
            echo "Removed swap file: $file"
        fi
    done
fi

for file in $files_to_remove; do
    swapfile_name=$(basename "$file")
    sed -i "/^\/$swapfile_name /d" /etc/fstab
    echo "Removed entry for $swapfile_name from /etc/fstab"
done

# BACKUP .genesisd FOLDER
cd
rsync -r --verbose --exclude 'data' ./.genesisd/ ./.genesisd_backup_reupdate/

# MAKE A BACKUP OF PRIV_VALIDATOR_STATE.JSON (JUST TO BE SURE)
cp ./.genesisd/data/priv_validator_state.json ./.genesisd_backup_reupdate/data/priv_validator_state.json

# DELETING OF .genesisd FOLDER (PREVIOUS INSTALLATIONS)
cd 
rm -r .genesisd

# BUILDING genesisd BINARIES
cd genesisd
make install

# COPY .genesisd_backup FOLDER to .genesisd FOLDER, EXCLUDE data
cd
rsync -r --verbose --exclude 'data' ./.genesisd_backup_reupdate/ ./.genesisd/

# FIND PATH TO THE OLDEST BACKUP FOLDER
oldest_dir=""
oldest_timestamp=0

for dir in ~/.genesisd_backup*/; do
    if [ -d "$dir" ]; then
        timestamp=$(stat -c %Y "$dir")

        if [ "$timestamp" -lt "$oldest_timestamp" ] || [ "$oldest_timestamp" -eq 0 ]; then
            oldest_timestamp=$timestamp
            oldest_dir="$dir"
        fi
    fi
done

# RESTORE KEYS FROM OLDEST BACKUP MADE DURING OR BEFORE V0.46 UPGRADE
# THERE MIGHT BE OLD BACKUP IN DIRECTORY NAMED .evmosd_backup, YOU CAN TRY USE THIS. 
cd ~/.genesisd
if [ -d "$oldest_dir" ]; then
    # FIRST REMOVE CURRENT KEYS BEFORE USING THE OLDER BACKUP
    find . -mindepth 1 -maxdepth 1 ! -name "data" ! -name "config" -exec rm -rv {} +
    
    # COPY OLDER KEYS
    cd
    rsync -av --exclude=config/ --exclude=data/ "$oldest_dir" .genesisd/
fi

# SETTING UP THE NEW chain-id in CONFIG
genesisd config chain-id genesis_29-2

#IMPORTING GENESIS STATE
cd 
cd .genesisd/config
rm -r genesis.json
wget https://github.com/alpha-omega-labs/genesisd/raw/neolithic/genesis_29-1-state/genesis.json
cd

# BACKUP MONIKER AND REMOVE CONFIG FILES AND ADDRBOOK (THE CONFIG FILES FOR v0.46 WERE DIFFERENT)
moniker=$(grep "moniker" .genesisd/config/config.toml | cut -d'=' -f2 | tr -d '[:space:]"')
rm .genesisd/config/app.toml .genesisd/config/config.toml .genesisd/config/addrbook.json

# REGENERATE CONFIG FILES, ADDRBOOK AND RESET TO IMPORTED genesis.json
genesisd tendermint unsafe-reset-all

# ADJUST SETTINGS
cd ~/.genesisd/config
sed -i "s/.*moniker = .*/moniker = \"$moniker\"/" config.toml
sed -i 's/^seeds = .*/seeds = ""/' config.toml
sed -i 's/^timeout_commit = .*/timeout_commit = "10s"/' config.toml
sed -i 's/^persistent_peers = .*/persistent_peers = ""/' config.toml # TODO: manual peers list
sed -i 's/^pex = .*/pex = false/g' config.toml
sed -i 's/^max_num_inbound_peers = .*/max_num_inbound_peers = 0/g' config.toml

sed -i 's/^minimum-gas-prices = .*/minimum-gas-prices = "50000000000el1"/g' app.toml
sed -i 's/^halt-height = .*/halt-height = 6751390/g' app.toml
sed -i '212s/.*/enable = false/' app.toml

# GET DATA SNAPSHOT AND EXTRACT FOLDER
cd ~/.genesisd
rm -r data

url1="http://135.181.135.29/data.tar.lz4"
url2="http://168.119.138.91/data.tar.lz4"
random_number=$((RANDOM % 2))
chosen_url=${url1}
if [ $random_number -eq 1 ]; then
    chosen_url=${url2}
fi
curl -o - -L "$chosen_url" | lz4 -c -d - | tar -x -C ~/.genesisd

# STARTING genesisd AS A SERVICE
 cd
 cd /etc/systemd/system
 rm -r genesisd.service
 wget https://raw.githubusercontent.com/alpha-omega-labs/genesisd/noobdate/genesisd.service
 systemctl daemon-reload
 systemctl enable genesisd.service
 systemctl disable genesisd # disable right afterwards to make sure it isn't going to turn on on a reboot.
 echo All set! 
 sleep 3s

# STARTING NODE
cat << "EOF"
     	    \\
             \\_
          .---(')
        o( )_-\_
       Node start                                                                                                                                                                                     
EOF
 
sleep 5s
# service genesisd start
# genesisd start
# ponysay "genesisd node service started, you may try *service genesisd status* command to see it! Welcome to GenesisL1 blockchain!" 
ponysay "Welcome to GenesisL1 blockchain! Do NOT turn on the node just yet before all validators are ready!" 
