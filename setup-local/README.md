# Setup

## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder** (database **AND** the priv_validator_state.json file!). Make a backup if needed.

This script takes care of everything to create a `tgenesis_54-1` chain for LOCAL testing purposes:

- It stops the service (if it exists)
- installs all the necessary dependencies
- Builds the binaries
- Generates a new _or_ attempts to overwrite an existing key
- Resets all configuration files to their default
- Creates an empty state file with correct denoms and short periods for voting, depositing and unbonding
- Initializes the node
- Installs the service

### Usage

```
sh quick-testnet-setup.sh --moniker string --key string
```

> _--moniker_ and _--key_ are optional and will default, respectively, to _mygenesismoniker_ and _mygenesiskey_. Advised is to always add the key alias, so that in case it already exists it asks whether you'd like to overwrite it or not. This way you prevent it from accidentally creating a _mygenesiskey_ if you do not desire this.

> [!TIP]
> You can add the `--local` flag if you would like to spin up a local testnet. This will immediately create a genesis validator using your key and set these configurations:
>
> - **[p2p]** addr_book_strict = false
> - **[p2p]** allow_duplicate_ip = true
> - **[api]** enabled = true
> - **[api]** enabled-unsafe-cors = true
>
> Be careful though, this will still use the `.tgenesis`-folder and wipe everything in the data folder!
