# Setup

> [!TIP]
> **The Lazy Tour**
> 
> If you prefer to run a script without having to do any manual preparation, use: [**node-setup-wizard.sh**](/setup/node-setup-wizard.sh).
>
> The wizard is an **interactive experience**; guiding you through the process while taking care of extra precautionary steps like _backing up previous installations_ and _creating keys_.

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## quick-node-setup.sh

> [!CAUTION]
> Running this will **wipe the entire data-folder**; database **AND** priv_validator_state.json file!
>
> Make a backup if needed: [utils/backup/create.sh](/utils/backup/create.sh).

As the name suggests, this script is a quick way to setup a node:

- It stops the service (if it exists)
- Installs all the necessary dependencies
- Builds the binaries
- Resets all configuration files to their default
- Fetches state, seeds and peers
- Initializes the node
- Installs the node as a service

### Usage

```
sh setup/quick-node-setup.sh <moniker>
```

**Example:** this initializes a node with the name _mynode_:

```
sh setup/quick-node-setup.sh mynode
```
> If you can't access the `genesisd` command afterwards, execute the `. ~/.bashrc` _or_ `source ~/.bashrc` command in your terminal.

After running, the node can be started using `systemctl start genesisd` and monitored with `journalctl -fu genesisd -ocat`. Later, if you ever wish to interact with your node or create a validator, you'll need to have a key _created_ or _imported_. If you haven't already done so, use either [utils/key/create.sh](/utils/key/create.sh) _or_ [utils/key/import.sh](/utils/key/import.sh).

## node-setup-wizard.sh

This script does the same as [`quick-node-setup.sh`](#quick-node-setupsh) but also takes care of:

- Backing up of an existing _.genesis_-folder (excluding the **database** in the _data_-folder)
- Backing up the entire _data_-folder (optional)
- Creating a new key (optional)
- And more configurable options (see **Usage** below)

> [!IMPORTANT]
> While this script creates a backup of an existing _.genesis_ folder (including _/data/priv_validator_state.json_), it doesn't do this for the entire database in the _/data_-folder! **If you don't want this to get wiped, then add the `--preserve-db` flag.**

### Usage

Running _sh setup/node-setup-wizard.sh_ (or using the _--help_, _--h_ or _-h_ flag) gives an overview of what the script is capable of:

```
Usage: sh setup/node-setup-wizard.sh --moniker string [...options]

   Options:
     --key string                     This creates a new key with the given alias, else no key gets generated.
     --backup-dir string              Set a different name for the backup directory. (default is time-based: see below for more information).
     --preserve-db                    This makes sure the complete /root/.genesis/data folder gets backed up via a move-operation (default: false).
     --no-restore                     This prevents restoring the old backed up /root/.genesis folder (default: false).
     --no-service                     This prevents the genesisd service from being installed (default: false).
     --no-start                       This prevents the genesisd service from starting at the end of the script (default: false).
     --prune [no|light|aggressive]    Prune options: no pruning (archiving node), light pruning, or aggressive pruning (default: light).
```

Here can be seen that the _--moniker_ is the only required field, but it is recommended to also add the _--key_ option if you haven't already created a key. This is useful to have if you later on wish to interact with your node (i.e. create a validator, do transactions etc.).

**Example:** this initializes a node with the name _supervalidator_, a key alias of _mygenesiskey_ and doesn't automatically start upon completion:

```
sh setup/node-setup-wizard.sh --moniker supervalidator --key mygenesiskey --no-start
```
> If you can't access the `genesisd` command afterwards, execute the `. ~/.bashrc` _or_ `source ~/.bashrc` command in your terminal.

### Backup mechanism

If a _.genesis_-folder already exists, then the _node-setup-wizard.sh_-script backs this up to a folder in the user's $HOME formatted as `.genesisd_backup_{date_time}`. This is a unique name based on the system's current time and will thus never overwrite previously made backups.

If you plan on running the script more often (testing purposes for instance), you could set the `--backup-dir` to a static name (ex. _$HOME/.genesis_backup_) to prevent creating a lot of unnecessary folders.

## upgrade.sh

> [!CAUTION]
> Running this will rename an existing `.genesisd` folder in the $HOME folder to `.genesis`! If you already have both a `.genesisd` and `.genesis` folder, the latter will be removed in order for a successful renaming of `.genesisd`!

This script should only be used by those who were already part of the network, but still use (older) binaries that had the node directory configured to `.genesisd`. This will:

- Stop the service
- Install all the necessary dependencies
- Rename .genesisd to .genesis
- Fetch the latest seeds and peers
- Builds the binaries

### Usage

```
sh setup/upgrade.sh
```
> After running, the node can be started using `systemctl start genesisd` and monitored with `journalctl -fu genesisd -ocat`.
