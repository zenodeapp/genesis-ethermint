# Setup

> [!NOTE]
> This folder is not specifically written for LOCAL testnet purposes. Use [setup-local](/setup-local) for this instead. Be careful though as this will still use the `.tgenesis`-folder and overwrite everything in that folder!

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder** (database **AND** the priv_validator_state.json file!). Make a backup if needed.

This script takes care of everything to join the `tgenesis_54-1` testnet:

- It stops the service (if it exists)
- Installs all the necessary dependencies
- Builds the binaries
- Resets all configuration files to their default
- Fetches state, seeds and peers
- Initializes the node
- Installs the service

If you haven't already, create or import a key using [utils/create-key.sh](/utils/create-key.sh) or [utils/import-key.sh](/utils/import-key.sh) and run the node using `systemctl start tgenesisd`.

### Usage

```
sh quick-testnet-setup.sh <moniker>
```

## genesis-validator.sh

This script uses `add-genesis-account` and `gentx` to create a genesis-validator. This will generate a file inside of the `/.tgenesis/config/gentx`-folder, which contains the transaction details for adding this validator to the `genesis.json` file.

> This does not mean that the validator gets added to the `genesis.json` file yet. Use this only if you're going to get included in the initial state of `tgenesis_54-1`.

### Usage

> [!IMPORTANT]
> This requires a key. If you haven't already created or imported one, use [utils/create-key.sh](/utils/create-key.sh) or [utils/import-key.sh](/utils/import-key.sh).

```
sh genesis-validator.sh <moniker> <key_alias>
```
