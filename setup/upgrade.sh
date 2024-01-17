#!/bin/bash

cat <<"EOF"

  /$$$$$$                                          /$$                 /$$         /$$       
 /$$__  $$                                        |__/                | $$       /$$$$       
| $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$      | $$      |_  $$       
| $$ /$$$$ /$$__  $$| $$__  $$ /$$__  $$ /$$_____/| $$ /$$_____/      | $$        | $$       
| $$|_  $$| $$$$$$$$| $$  \ $$| $$$$$$$$|  $$$$$$ | $$|  $$$$$$       | $$        | $$       
| $$  \ $$| $$_____/| $$  | $$| $$_____/ \____  $$| $$ \____  $$      | $$        | $$       
|  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$ /$$$$$$$/| $$ /$$$$$$$/      | $$$$$$$$ /$$$$$$     
 \______/  \_______/|__/  |__/ \_______/|_______/ |__/|_______/       |________/|______/     
                                                                                             
EOF

echo ""
echo "This script should only be used if you are on an older version of the Evmos fork of GenesisL1."
echo "This means you have an existing '.genesisd' folder. This script will stop the node, build the new"
echo "binaries and move everything to '.genesis', since this version expects the node directory"
echo "to be in this folder."
echo ""
echo "WARNING:"
echo "    - This will rename .genesisd to .genesis, if you already have a .genesis folder in $HOME, then"
echo "      this will be overwritten."
echo "    - This will fetch the latest peers and refresh your persistent_peers and seeds fields in the"
echo "      config.toml file."
echo ""
read -p "Do you want to continue? (y/N): " ANSWER

ANSWER=$(echo "$ANSWER" | tr 'A-Z' 'a-z')  # Convert to lowercase

if [ "$ANSWER" != "y" ]; then
    echo "Aborted."
    exit 1
fi

# Root of the current repository
REPO_ROOT=$(cd "$(dirname "$0")"/.. && pwd)

# Source the variables file
. "$REPO_ROOT/utils/_variables.sh"

# Stop services
systemctl stop $BINARY_NAME

# cd to root of the repository
cd $REPO_ROOT

# Rename .genesisd to .genesis
GENESISD_DIR="$HOME/.genesisd"
GENESIS_DIR="$NODE_DIR"

# Check if .genesisd directory exists
if [ -d "$GENESISD_DIR" ]; then
    # Check if .genesis directory already exists
    if [ -d "$NODE_DIR" ]; then
        rm -rf "$NODE_DIR"
    fi

    # Rename .genesisd to .genesis
    mv "$GENESISD_DIR" "$NODE_DIR"
    echo "Renamed .genesisd to .genesis."
fi

# Fetch latest seeds and peers list from genesis-parameters repo
sh ./utils/fetch-peers.sh

# Install binaries
make install && {
    echo ""
    echo "Upgrade was a success!"
    echo ""
    echo "When ready, turn on your node again using '$BINARY_NAME start' or 'systemctl start $BINARY_NAME'!"
}