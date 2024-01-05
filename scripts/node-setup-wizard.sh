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
This script installs the genesis_29-2 blockchain full node while running under root user.

GENESIS L1 is a highly experimental decentralized project, provided AS IS, with NO WARRANTY.
GENESIS L1 IS A NON COMMERCIAL OPEN DECENTRALIZED BLOCKCHAIN PROJECT RELATED TO SCIENCE AND ART
  
  Mainnet EVM chain ID: 29
  Chain ID: genesis_29-2
  Blockchain utilitarian coin: L1
  Min. coin unit: el1
  1 L1 = 1 000 000 000 000 000 000 el1 	
  Initial supply: 21 000 000 L1
  genesis_29-2 at the time of upgrade circulation: ~29 000 000 L1
  Mint rate: < 20% annual
  Block target time: ~11s
  Binary name: genesisd
  genesis_29-1 start: Nov 30, 2021
  genesis_29-2 start: Apr 16, 2022
  
EOF

# User-configurable variables
backup_dir=".genesis_backup_$(date +"%Y%m%d%H%M%S")"

# Fixed/default variables (do not modify)
chain_id="genesis_29-2"
node_dir=".genesis"
repo_dir=$(cd "$(dirname "$0")"/.. && pwd)
moniker=""
key=""
preserve_db=false
no_restore=false
no_service=false
no_start=false

if [ "$#" -lt 1 ]; then
    echo "Usage: sh $0 \e[3m--moniker string\e[0m \e[3m[...options]\e[0m"
    echo ""
    echo "   Options:"
    echo "     \e[3m--key string\e[0m             This creates a new key with the given alias, else no key gets generated."
    echo "     \e[3m--backup-dir string\e[0m      Set a different name for the backup directory. (default is time-based, ex: $backup_dir)."
    echo "     \e[3m--preserve-db\e[0m            This makes sure the complete /data folder gets backed up via a move-operation (default: false)."
    echo "     \e[3m--no-restore\e[0m             This prevents restoring the old backed up $node_dir folder in the $HOME folder (default: false)."
    echo "     \e[3m--no-service\e[0m             This prevents the genesisd service from being made (default: false)."
    echo "     \e[3m--no-start\e[0m               This prevents the genesisd service from starting at the end of the script (default: false)."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as the root user."
    exit 1
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
        --moniker)
            shift
            if [ -z "$1" ] || [ "$(echo "$1" | cut -c 1)" = "-" ]; then
                echo "Error: --moniker option requires a non-empty value."
                exit 1
            fi
            moniker="$1"
            ;;
        --key)
            shift
            if [ -z "$1" ] || [ "$(echo "$1" | cut -c 1)" = "-" ]; then
                echo "Error: --key option requires a non-empty value."
                exit 1
            fi
            key="$1"
            ;;
        --backup-dir)
            shift
            if [ -z "$1" ] || [ "$(echo "$1" | cut -c 1)" = "-" ]; then
                echo "Error: --backup-dir option requires a non-empty value."
                exit 1
            fi
            backup_dir="$1"
            ;;
        --preserve-db)
            preserve_db=true
            ;;
        --no-restore)
            no_restore=true
            ;;
        --no-service)
            no_service=true
            ;;
        --no-start)
            no_start=true
            ;;
        *)
            echo "Error: Unknown option $1"
            exit 1
            ;;
    esac
    shift
done

# Check if required options are provided
if [ -z "$moniker" ]; then
    echo "Error: --moniker is required."
    exit 1
fi

echo "Script configurations:"
echo " o Moniker will be set to: $moniker."
if [ ! -z "$key" ]; then
    echo " o Will create a key with the alias: $key."
fi
echo " o Backup directory is set to: $HOME/$backup_dir."
$preserve_db && echo " o The complete /data folder will be backed up (\e[3m--preserve-db\e[0m: $preserve_db)."
$no_restore && echo " o Will not restore a previously found $node_dir folder (\e[3m--no-restore\e[0m: $no_restore)."
$no_service && echo " o Will skip installing genesisd as a service (\e[3m--no-service\e[0m: $no_service)."
if ! $no_service && $no_start; then
    echo " o Will skip starting the genesisd service at the end of the script (\e[3m--no-start\e[0m: $no_start)."
fi

echo ""
echo "Please note the following:"
echo " - If a Cosmovisor process is running, it will be killed."
echo " - If the Genesis daemon is running, it will be halted."
echo " - Existing app.toml and config.toml files will get overwritten, but backed up safely in the $HOME/$backup_dir folder."
! $preserve_db && echo " - Any existing Genesis database (in the /data folder) will get wiped! Use the flag \e[3m--preserve-db\e[0m if this is not desirable."
echo ""

read -p "Do you still wish to continue? (y/N): " answer
answer=$(echo "$answer" | tr 'A-Z' 'a-z')  # Convert to lowercase

if [ "$answer" != "y" ]; then
  echo "Aborted."
  exit 1
fi

echo "Continuing..."

systemctl stop genesisd
pkill cosmovisor

sleep 3s

# Helper-function: adds a line to a file if it doesn't already exist (to prevent duplicates)
add_line_to_file() {
    local line="$1"
    local file="$2"
    local use_sudo="$3"

    if ! grep -qF "$line" "$file"; then
        if $use_sudo; then
            echo "$line" | sudo tee -a "$file" > /dev/null
        else
            echo "$line" >> "$file"
        fi

        echo "Line '$line' added to $file."
    else
        echo "Line '$line' already exists in $file."
    fi
}

# System update and installation of dependencies
sudo apt-get update -y
sudo apt-get install jq git wget make gcc build-essential snapd wget -y
snap install go --channel=1.20/stable --classic
snap refresh go --channel=1.20/stable --classic
snap install ponysay
export PATH=$PATH:$(go env GOPATH)/bin
add_line_to_file 'export PATH=$PATH:$(go env GOPATH)/bin' ~/.bashrc false

# Global change of open file limits
add_line_to_file "* - nofile 50000" /etc/security/limits.conf false
add_line_to_file "root - nofile 50000" /etc/security/limits.conf false
add_line_to_file "fs.file-max = 50000" /etc/sysctl.conf false
ulimit -n 50000

# Backup of previous configuration if one existed
if [ -e ~/"$node_dir" ]; then
    rsync -qr --verbose --exclude 'data' --exclude 'config/genesis.json' ~/$node_dir/ ~/"$backup_dir"/
    echo "Backed up previous $node_dir folder."
    
    rm -r ~/"$backup_dir"/data
    mkdir -p ~/"$backup_dir"/data
    
    if $preserve_db; then
        # A move is more feasible, especially with big data.
        if mv ~/$node_dir/data ~/"$backup_dir"/; then
            echo "Backed up entire /data folder."
        fi
    else
        if cp ~/$node_dir/data/priv_validator_state.json ~/"$backup_dir"/data/priv_validator_state.json; then
            echo "Backed up previous priv_validator_state.json file."
        fi
    fi
fi

# Deletion of the previous configuration
rm -rf ~/$node_dir

# cd to root of the repository
cd $repo_dir

# Building genesisd binaries
ponysay "In 5 seconds the wizard will start to build the binaries for genesisd..."
sleep 5s
make install

# Restore backup if backup exists and --no-restore is false
if ! $no_restore && [ -e ~/"$backup_dir" ]; then
    rsync -qr --verbose --exclude 'data' --exclude 'config/genesis.json' ~/"$backup_dir"/ ~/$node_dir/
    echo "Restored previous $node_dir folder."
fi

# Set chain-id
genesisd config chain-id $chain_id

# Create key
if [ ! -z "$key" ]; then
    genesisd config keyring-backend os
    ponysay "GET READY TO WRITE YOUR SECRET SEED PHRASE FOR YOUR NEW KEY NAMED: $key."
    sleep 10s
    genesisd keys add $key --keyring-backend os --algo eth_secp256k1

    # Check if the exit status of the previous command is equal to zero (zero means it succeeded, anything else means it failed)
    if [ $? -eq 0 ]; then
      echo "Press Enter to continue..."
      read REPLY
    fi
fi

# Init node
genesisd init $moniker --chain-id $chain_id -o

# State and chain specific configurations (i.e. timeout_commit 10s, min gas price 50gel).
cp $repo_dir/configs/default_app.toml ~/$node_dir/config/app.toml
cp $repo_dir/configs/default_config.toml ~/$node_dir/config/config.toml
cp $repo_dir/states/$chain_id/genesis.json ~/$node_dir/config/genesis.json
# Set moniker again since the configs got overwritten
sed -i "s/moniker = .*/moniker = \"$moniker\"/" ~/$node_dir/config/config.toml

# Reset to imported genesis.json
genesisd tendermint unsafe-reset-all

# Restore priv_validator_state.json or the entire /data folder if backup exists and --no-restore is false.
if ! $no_restore && [ -e ~/"$backup_dir" ]; then
    if $preserve_db; then
        if mv ~/$backup_dir/data/* ~/"$node_dir"/data/; then
            echo "Restored previous /data folder."

            # the mv removes the priv_validator_state from the backup, so reintroduce it back.
            cp ~/"$node_dir"/data/priv_validator_state.json ~/$backup_dir/data/priv_validator_state.json;
        fi
    else
        if cp ~/"$backup_dir"/data/priv_validator_state.json ~/$node_dir/data/priv_validator_state.json; then
            echo "Restored backed up priv_validator_state.json file"
        fi
    fi
fi

# Set genesisd as a systemd service
if ! $no_service; then
    cp "$repo_dir/services/genesisd.service" /etc/systemd/system/genesisd.service

    systemctl daemon-reload
    systemctl enable genesisd
    sleep 3s

    # Start node if user hasn't run this wizard with the no-start flag
    if ! $no_start; then
cat << "EOF"
     	    \\
             \\_
          .---(')
        o( )_-\_
       Node start                                                                                                                                                                                     
EOF
 
        sleep 5s
        systemctl start genesisd
        ponysay "genesisd node service started, you may try *journalctl -fu genesisd -ocat* or *service genesisd status* command to see it! Welcome to GenesisL1 blockchain!"
    else
        ponysay "genesisd node service installed, use *service genesisd start* to start it! Welcome to GenesisL1 blockchain!"
    fi
else
    ponysay "genesisd node is ready, use *service genesisd start* to start it! Welcome to GenesisL1 blockchain!"
fi