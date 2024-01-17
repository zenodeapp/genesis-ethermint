# Setup

> [!NOTE]
> The scripts in this folder are not specifically written for **local** testnet purposes.
>
> If you plan on **creating** a testnet or running one **locally**, head over to [/setup-local](/setup-local) instead.

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder**; database **AND** priv_validator_state.json file!
>
> Make a backup if needed: [utils/backup/create.sh](/utils/backup/create.sh).

This script takes care of everything to **join** the `tgenesis_54-1` testnet:

- It stops the service (if it exists)
- Installs all the necessary dependencies
- Builds the binaries
- Resets all configuration files to their default
- Fetches state, seeds and peers
- Initializes the node
- Installs the node as a service

### Usage

```
sh setup/quick-testnet-setup.sh <moniker>
```

## genesis-validator.sh

> [!IMPORTANT]
> _genesis-validator.sh_ requires a key.
>
> If you haven't already created or imported one, use: [utils/key/create.sh](/utils/key/create.sh) _or_ [utils/key/create.sh](/utils/key/create.sh).

This script uses `add-genesis-account` and `gentx` to create a _genesis_ validator. This will generate a file inside of the `/.tgenesis/config/gentx`-folder, which will contain the transaction details for adding this validator to the `genesis.json` file.

> This does not mean that your validator will get added to the _genesis.json_-file just yet. Use this only if you're going to get included in the initial state of `tgenesis_54-1`.

### Usage

```
sh setup/genesis-validator.sh <moniker> <key_alias>
```
