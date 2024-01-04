# GenesisL1 blockchain

<p align="center">
  <img src="https://github.com/zenodeapp/genesisL1/assets/108588903/be368fa2-a154-48a6-b04b-8eb452b02033" alt="GenesisL1" width="150" height="150"/>
</p>

<p align="center">
   <i>A source code fork of Evmos and Ethermint.</i>
</p>

<p align="center">
   Cosmos SDK v0.44.5-patch
</p>

> [!IMPORTANT]
> **From Evmos to Cronos**
> 
> This repository is an Evmos-fork and was used before we upgraded to a Cronos-fork. For those who want to run a full-node it's required to start out in this repository and sync up till height `insert_height_here`.

## Node requirements

- 300GB+ good hard drive disk
- 8GB+ RAM
- 4 CPU Threads
- Good Internet Connection

## Instructions

Only follow these steps if you wish to set up a full node, else you could immediately go to the `genesis-cronos` repository.

### 1. Cloning the repository

```
git clone https://github.com/zenodeapp/genesis-evmos.git
```

### 2. Checkout the right tag/branch

```
git checkout v0.5.0
```

### 3. Setting up your node

> [!CAUTION]
> Both these scripts wipe any existing database in the data folder of .genesis. If this is not desired, then make sure to create a backup!

As this repository is only required for full node syncing, we've only included two scripts. Both share the same purpose of initializing the node and starting the sync process till height `insert_height_here`, but are tailored for two specific audiences:

- **The less experienced**

   [node-setup-wizard.sh](scripts/node-setup-wizard.sh) is made for those who prefer to run a script without having to do any manual editing. It's a more interactive experience with visual feedback. A simple one-liner would be:
  ```
  sh scripts/node-setup-wizard.sh --moniker your_moniker_name --key your_key_alias
  ```
  > _your_moniker_name_ is the name of your node and _your_key_alias_ the name for the key that will be generated.

  > This will not backup any existing `.genesis/data` folder! if you do not want this to get wiped, add the `--backup-data` flag!
  
  > More options or flags could be set; see the [\/scripts](scripts/)-folder for more details on this.
  
- **The more experienced**

   [quick-node-setup.sh](scripts/quick-node-setup.sh) is made for those who prefer and are used to manually configuring their setup. This is a slim-sized script, containing only the necessary commands for starting a full node sync. Suggested is to treat the script as a manual rather than one you run without careful consideration _(though, this can be done)_.

### 4. Sync your node

The node will sync till height `insert_height_here` and automatically crash, which is expected. Once you've gotten this far, continue with the instructions in the `genesis-cronos` repository.
