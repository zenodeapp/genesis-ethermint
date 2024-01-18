<h1 align="center">
  GenesisL1 Testnet (Evmos fork)
</h1>

<p align="center">
  <ins>Release <b>v0.5.0</b> ~ Evmos <b>v0.3.0</b></ins>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/zenodeapp/genesis-parameters/main/assets/l1-logo.png" alt="GenesisL1" width="150" height="150"/>
</p>

<p align="center">
  Chain ID <b>tgenesis_54-1</b>
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

The instructions provided here will only be suitable for those who would like to **join** the **public** testnet: `tgenesis_54-1`. If you instead want to **create a local testnet**, see [/setup-local](/setup-local).

> [!NOTE]
> More details for every script mentioned in this README can be found in the folders where they are respectively stored: [/setup](/setup), [/setup-local](/setup-local) or [/utils](/utils).

### 1. Cloning the repository

```
git clone https://github.com/zenodeapp/genesis-ethermint.git
```

### 2. Checkout the right tag/branch

```
git checkout tgenesis-v0.5.0
```

### 3. Node setup

```
sh setup/quick-testnet-setup.sh <moniker>
```

> This wipes the whole _.tgenesis/data_ folder, so proceed with caution!

> [!IMPORTANT]
> If you can't access the `tgenesisd` command afterwards, execute the `. ~/.bashrc` _or_ `source ~/.bashrc` command in your terminal.

### 4. Create or import a key (optional)

A key is necessary to interact with the network/node. If you haven't already created one, either import one or generate a new one, using:

```
sh utils/key/create.sh <key_alias>
```

OR

```
sh utils/key/import.sh <key_alias> <private_eth_key>
```

> _<private_eth_key>_ is the private key for a (wallet) address you already own.

### 5. Node syncing

If everything went well, you should now be able to run your node using:

```
systemctl start tgenesisd
```

and see its status with:

```
journalctl -fu tgenesisd -ocat
```

### 6. Explore utilities (optional)

> [!TIP]
> The [/utils](/utils)-folder contains useful utilities one could use to manage their node (e.g. for fetching latest seeds and peers, fetching the genesis state, quickly shifting your config's ports etc.). To learn more about these, see the [README](utils/README.md) in the folder.
