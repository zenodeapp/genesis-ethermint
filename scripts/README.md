# Scripts

> [!CAUTION]
> Both these scripts wipe any existing database in the data folder of `.genesis`. If this is not desired, then make sure to create a backup!

## node-setup-wizard.sh

> [!NOTE]
> This script makes sure to create a backup of an existing `.genesis` folder (including the `priv_validator_state.json` file).

### Usage

As said in [README.md](../README.md), this script is made for those who are less experienced and prefer an easy setup. Running `sh scripts/node-setup-wizard.sh` gives an overview of what the script is capable of:

```
Usage: sh node-setup-wizard.sh --moniker string [...options]

   Options:
     --key string             This creates a new key with the given alias, else no key gets generated.
     --backup-dir string      Set a different name for the backup directory. (default is time-based: see below for more information)
     --no-service             This prevents the genesisd service from being made (default: false).
     --no-start               This prevents the genesisd service from starting at the end of the script (default: false).
     --hard-reset             This completely removes the old .genesis folder (it will still leave a copy as a backup, excluding db data, in your /root folder).
```
> Here can be seen that the _--moniker_ is the only required field, unlike the _--key_ option; which may have been expected given the example in the repo's main [README.md](../README.md).

### Backup directory

If a `.genesis` folder already exists, the `node-setup-wizard.sh` script will back this up to a folder formatted as `.genesisd_backup_{date_time}`. This is a unique name based on the system's current time. Therefore running the script multiple times will continue to create new backup folders.

If you plan on running the `node-setup-wizard.sh` script more often (testing purposes for instance), you could set the `--backup-dir` to a static name to prevent creating a lot of unnecessary backups.

## quick-node-setup.sh

> [!CAUTION]
> This script does not contain any backup logic whatsoever, so proceed with caution.

### Usage

As said in [README.md](../README.md), this script is made for those who are more experienced and prefer manual configuration. We suggest reading the script and running the commands yourself, unless you're confident the script will work correctly in your setup.
