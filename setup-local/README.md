# Setup

## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder** (database **AND** the priv_validator_state.json file!). Make a backup if needed.

This script takes care of everything to create a `tgenesis_54-1` chain for LOCAL testing purposes:

- It stops the service (if it exists)
- installs all the necessary dependencies
- Builds the binaries
- Generates a new _or_ attempts to overwrite an existing key
- Resets all configuration files to their default, but with the following changes:
  > - **[p2p]** addr_book_strict = false
  > - **[p2p]** allow_duplicate_ip = true
  > - **[api]** enabled = true
  > - **[api]** enabled-unsafe-cors = true
- Creates an empty state file with correct denoms and short periods for voting, depositing and unbonding
- Initializes the node
- Installs the service

### Usage

```
sh quick-testnet-setup.sh <moniker>
```

## create-validator.sh

After setting up a testnet,

> [!CAUTION]
> Running this will **wipe the whole data-folder** (database **AND** the priv_validator_state.json file!). Make a backup if needed.

This script takes care of everything to create a `tgenesis_54-1` chain for LOCAL testing purposes:

- It stops the service (if it exists)
- installs all the necessary dependencies
- Builds the binaries
- Generates a new _or_ attempts to overwrite an existing key
- Resets all configuration files to their default, but with the following changes:
  > - **[p2p]** addr_book_strict = false
  > - **[p2p]** allow_duplicate_ip = true
  > - **[api]** enabled = true
  > - **[api]** enabled-unsafe-cors = true
- Creates an empty state file with correct denoms and short periods for voting, depositing and unbonding
- Initializes the node
- Installs the service

### Usage

```
sh create-validator.sh <moniker> <key_alias>
```
