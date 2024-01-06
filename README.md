<h1 align="center">
  GenesisL1 Mainnet (Evmos fork)
</h1>

<p align="center">
  <ins>Release <b>v0.5.0</b> ~ Evmos <b>v0.3.0</b></ins>
</p>

<p align="center">
  <img src="https://github.com/zenodeapp/genesisL1/assets/108588903/be368fa2-a154-48a6-b04b-8eb452b02033" alt="GenesisL1" width="150" height="150"/>
</p>

<p align="center">
  Chain ID <b>genesis_29-2</b>
</p>

<p align="center">
   A source code fork of <b>Evmos</b> and <b>Ethermint</b>
</p>

<p align="center">
  Cosmos SDK <b>v0.44.5-patch</b>
</p>

---

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

As this repository is only required for full node syncing, we've only included two scripts. Both share the same purpose of initializing the node and starting the sync process till height `insert_height_here`, but are tailored for two specific audiences:

- **Normal Users**

   **[node-setup-wizard.sh](scripts/node-setup-wizard.sh)** is made for those who prefer to run a script without having to do any manual preparation. It's a more interactive experience with visual feedback and automatically backs up previous installations if there were any.

  A one-liner to initialize a node and generate a key _(optional)_ would be:
  ```
  sh scripts/node-setup-wizard.sh --moniker your_moniker_name --key your_key_alias
  ```
  > Running this will not backup any database in an existing _.genesis/data_ folder! If you do not want this to get wiped, then add the `--preserve-db` flag! More options or flags could be set; see the [\/scripts](scripts/)-folder for more information on this.
  
- **Advanced Users**

   **[quick-node-setup.sh](scripts/quick-node-setup.sh)** is made for those who prefer and are used to manually configuring their setup. This is a slim-sized script, **does not make any backups (!)** and contains only the necessary commands for starting a full node sync. Suggested is to treat the script as a guide rather than one you run without careful consideration _(though, this could also be done)_.

  A one-liner to initialize a node and generate a key with this script would be:
  ```
  sh scripts/quick-node-setup.sh your_moniker_name your_key_alias
  ```
  > The args are optional and default to _mygenesismoniker_ and _mygenesiskey_ if they're not provided.
  
### 4. Sync your node

The node will sync till height `insert_height_here` and automatically crash, which is expected. Once you've gotten this far, continue with the instructions in the `genesis-cronos` repository.
