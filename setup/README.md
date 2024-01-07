# Setup

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## install-service.sh

This script installs the `genesisd` service, which will automatically start the node whenever the device reboots (see [genesisd.service](/services/genesisd.service)). Since this file already gets called from within the other scripts, it is not required to call this yourself.

## node-setup-wizard.sh

As said in the [README.md](../README.md), this script is more of an interactive experience and takes care of some extra precautionary steps. It's made for those who prefer to run a script without having to do any manual preparation like backing up previous installations.

> [!IMPORTANT]
> While this script creates a backup of an existing _.genesis_ folder (including _/data/priv_validator_state.json_), it doesn't do this for the entire database in the _/data_-folder! **If you don't want this to get wiped, then add the `--preserve-db` flag.**

### Usage

Running _sh node-setup-wizard.sh_ gives an overview of what the script is capable of:
```
Usage: sh node-setup-wizard.sh --moniker string [...options]

   Options:
     --key string             This creates a new key with the given alias, else no key gets generated.
     --backup-dir string      Set a different name for the backup directory. (default is time-based: see below for more information).
     --preserve-db            This makes sure the complete /data folder gets backed up via a move-operation (default: false).
     --no-restore             This prevents restoring the old backed up .genesis folder in the /root folder (default: false).
     --no-service             This prevents the genesisd service from being installed (default: false).
     --no-start               This prevents the genesisd service from starting at the end of the script (default: false).
```
> Here can be seen that the _--moniker_ is the only required field, but it is recommended to also add the _--key_ option if you haven't already created a key. This is useful to have if you later on wish to interact with your node (i.e. create a validator, do transactions etc.).

**Example:** this initializes a node with the name _supervalidator_, a key alias of _mygenesiskey_ and doesn't automatically start upon completion:
```
sh node-setup-wizard.sh --moniker supervalidator --key mygenesiskey --no-start
```

### Backup mechanism

If a _.genesis_-folder already exists, then the _node-setup-wizard.sh_-script backs this up to a folder in the user's $HOME formatted as `.genesisd_backup_{date_time}`. This is a unique name based on the system's current time and will thus never overwrite previously made backups.

If you plan on running the script more often (testing purposes for instance), you could set the `--backup-dir` to a static name (ex. _.genesis_backup_) to prevent creating a lot of unnecessary folders.

## quick-node-setup.sh

> [!CAUTION]
> As said in [README.md](../README.md), this script is made moreso for those who prefer to manually configure their setup.
>
> While this script is much easier to _read_, it does make it more risky to use **for it not containing any backup logic (!) or configurable options whatsoever**. We suggest to either inspect the script and run the commands yourself or adapt it to your circumstances until you're confident enough that it won't lead to unexpected loss in data. 

**Example:** this initializes a node with the name _mynode_ and key alias  _mykey_:
```
   sh quick-node-setup.sh mynode mykey
```
> The args are optional and default to mygenesismoniker and mygenesiskey if they're not provided.
