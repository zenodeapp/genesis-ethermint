# Setup (Local)

> [!IMPORTANT]
> The scripts in this folder are specifically written for **local** testnet purposes only.
>
> If you want to **join** a public testnet, then head over to [/setup](/setup) instead.
> 
## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder**; database **AND** priv_validator_state.json file!
>
> Make a backup if needed: [utils/backup/create.sh](/utils/backup/create.sh).

This script takes care of everything to **create** a `tgenesis_54-1` chain for **local** testing purposes:

- It stops the service (if it exists)
- Installs all the necessary dependencies
- Builds the binaries
- Generates a new _or_ attempts to overwrite an existing key
- Resets all configuration files to their default _and sets_:
  - **[p2p] addr_book_strict** = _false_
  - **[p2p] allow_duplicate_ip** = _true_
  - **[api] enabled** = _true_
  - **[api] enabled-unsafe-cors** = _true_
- Creates an empty _genesis.json_-file and sets:
  - **"chain_id"**: _"tgenesis_54-1"_
  - **"denom"**: _"el1"_
  - **"max_deposit_period"**: _"100s"_
  - **"voting_period"**: _"100s"_
  - **"token_pair_voting_period"**: _"100s"_
  - **"unbonding_time"**: _"100s"_
- Initializes the node
- Installs the service

### Usage

```
sh setup-local/quick-testnet-setup.sh <moniker>
```
> If you can't access the `tgenesisd` command afterwards, execute the `. ~/.bashrc` _or_ `source ~/.bashrc` command in your terminal.

## create-validator.sh

> [!IMPORTANT]
> _create-validator.sh_ requires a key.
>
> If you haven't already created or imported one, use: [utils/key/create.sh](/utils/key/create.sh) _or_ [utils/key/import.sh](/utils/key/import.sh).

This script leverages [setup/genesis-validator.sh](/setup.genesis-validator.sh) which generates a genesis transaction for creating a validator. This then gets applied to _genesis.json_ by running `collect-gentxs` and `tendermint unsafe-reset-all`, making the genesis state file ready for actual use.

### Usage

```
sh setup-local/create-validator.sh <moniker> <key_alias>
```
