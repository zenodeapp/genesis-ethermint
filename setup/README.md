# Setup

## cronos-upgrade-proposal.sh

This script creates a proposal to upgrade to cronos and immediately votes yes through governance. Needless to say, this requires you to already have joined the testnet (i.e. by using `quick-testnet-setup.sh`). For the plan name it uses _plan_cronos_.

```
Usage: sh cronos-upgrade-proposal.sh <KEY_ALIAS> <UPGRADE_HEIGHT> [NEXT_PROPOSAL_ID]
 - [NEXT_PROPOSAL_ID] is optional, but should point towards the upgrade proposal to vote on (default: 1)
```

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## generate-validator.sh

This script uses `add-genesis-account` and `gentx` to create a genesis-validator. This will create a file inside of the `/.tgenesis/config/gentx`-folder, which contains the transaction details for adding this validator to the `genesis.json` file.

This file is necessary to send in if you want to join as a genesis validator in the testnet.

Though if you're only running a testnet locally, either run `quick-testnet-setup.sh --local` (which will automatically add your key as a genesis validator) or stop the node and run `generate-validator.sh` followed by a `tgenesisd collect-gentxs && tgenesisd tendermint unsafe-reset-all`.

## quick-testnet-setup.sh

> [!CAUTION]
> Running this will **wipe the whole data-folder** (database **AND** the priv_validator_state.json file!). Make a backup if needed.

This script takes care of everything to join the `tgenesis_54-1` testnet, run it using:
```
sh quick-testnet-setup.sh [MONIKER] [KEY_ALIAS]
```
> [MONIKER] and [KEY_ALIAS] are optional and will default, respectively, to _mygenesismoniker_ and _mygenesiskey_. Advised is to always add the key alias, so that in case it already exists it will ask whether you'd like to overwrite it or not. This way you prevent it from creating a new key every time you run this.
> 
> You can add the `--local` flag if you would like to spin up a local testnet. Be careful though, this will still use the `.tgenesis`-folder and wipe the data folder!

### What it does
- It stops the service (if it exists)
- installs all the necessary dependencies
- Builds the binaries
- Generates a key
- Resets all configuration files
- Fetches state, seeds and peers
- Initializes the node
- Installs the service
- Runs the node
