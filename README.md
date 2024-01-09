<h1 align="center">
  GenesisL1 Testnet (Evmos fork)
</h1>

<p align="center">
  <ins>Release <b>v0.5.0</b> ~ Evmos <b>v0.3.0</b></ins>
</p>

<p align="center">
  <img src="https://github.com/zenodeapp/genesisL1/assets/108588903/be368fa2-a154-48a6-b04b-8eb452b02033" alt="GenesisL1" width="150" height="150"/>
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

### 1. Cloning the repository

```
git clone https://github.com/zenodeapp/genesis-evmos.git
```

### 2. Checkout the right tag/branch

```
git checkout tgenesis-v0.5.0
```

### 3. Setting up your node

> [!NOTE]
> There are more scripts in the setup-folder. To learn more, see [README](setup/README.md).

```
sh setup/quick-testnet-setup.sh --moniker your_moniker_name --key your_key_alias 
```
> This wipes the whole _.tgenesis/data_ folder, so proceed with caution!
> 
> _--moniker_ and _--key_ are both optional. You could also add `--local` to spin up a local testnet. For more information, see the [\/setup](setup/)-folder.

### 4. Monitoring your node

If everything went well, your node should be running. Use `journalctl -fu tgenesisd -ocat` (or any other way you're used to) to see its status!

> [!TIP]
> There are some useful utilities in the utils-folder (e.g. for fetching seeds and peers, fetching the genesis state, shifting ports etc.). To learn more about these, see the [README](utils/README.md).

