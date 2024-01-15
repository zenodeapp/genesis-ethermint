<h1 align="center">
  GenesisL1 Mainnet (Evmos fork)
</h1>

<p align="center">
  <ins>Release <b>v0.5.0</b> ~ Evmos <b>v0.3.0</b></ins>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/zenodeapp/genesis-parameters/main/assets/l1-logo.png" alt="GenesisL1" width="150" height="150"/>
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

> [!WARNING]
> Only follow these steps if you wish to set up a full node, else you could immediately go to the [`genesis-crypto`](https://github.com/zenodeapp/genesis-crypto) repository.

> [!NOTE]
> More details for every script mentioned in this README can be found in the folders where they are respectively stored: [/setup](/setup) or [/utils](/utils).

### 1. Cloning the repository

```
git clone https://github.com/zenodeapp/genesis-ethermint.git
```

### 2. Checkout the right tag/branch

```
git checkout genesis-v0.5.0
```

### 3. Node setup

There are two scripts¹ one could use to initialize a node:

- [**node-setup-wizard.sh**](setup/node-setup-wizard.sh)

  Use this script if you prefer to setup a node without having to do any manual preparation. It's a more interactive experience with visual feedback and takes care of things like: _backing up previous setups_, _creating keys_ and _starting the node_.

  A one-liner to initialize a node _and_ generate a key _(optional)_ would be:
  ```
  sh node-setup-wizard.sh --moniker your_moniker_name --key your_key_alias
  ```
  > **WARNING:** running this won't backup the **database** in an existing _.genesis/data_ folder!
  >
  > If you don't want this to get wiped, add the `--preserve-db` flag!
  >
  > More flags can be set; see the [README](setup/README.md) in the [\/setup](setup/)-folder for more information on this.
  
- **[quick-node-setup.sh](setup/quick-node-setup.sh)**

   This is a less bulky script, **does not create any backups (!) or keys** and contains only the necessary commands for initializing a full node. Its readability is higher, thus users who are used to manually setting up a node could use this script as a guide.

  A one-liner to initialize a node would be:
  ```
  sh quick-node-setup.sh your_moniker_name
  ```

  > **NOTE:** this won't auto-start the node, which can be done using `systemctl start genesisd`.
  > 
  > **WARNING:** no keys will be imported or created, which can be done directly using the CLI _or_ see [utils/create-key.sh](/utils/create-key.sh) or [utils/import-key.sh](/utils/import-key.sh).

---

¹ As this repository is only required for full node syncing, we've only included scripts for **initializing a node and starting the sync process** till height `insert_height_here`. Scripts for e.g. _creating a validator_ will only be available in the [`genesis-crypto`](https://github.com/zenodeapp/genesis-crypto) repository.

### 4. Node syncing

The node will sync till height `insert_height_here` and automatically crash, which is expected. Once you've gotten this far, continue with the instructions in the [`genesis-crypto`](https://github.com/zenodeapp/genesis-crypto) repository.
> Monitor your node's status using `journalctl -fu genesisd -ocat`.

### 5. Explore utilities (optional)

> [!TIP]
> The [/utils](/utils)-folder contains useful utilities one could use to manage their node (e.g. for fetching latest seeds and peers, fetching the genesis state, quickly shifting your config's ports etc.). To learn more about these, see the [README](utils/README.md) in the folder.
