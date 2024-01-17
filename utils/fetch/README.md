## /fetch

### [peers.sh](../fetch/peers.sh)

This script fetches the (most recent) seeds and peers for the chain-id configured in the [\_variables.sh](../_variables.sh) file and adds it to the `seeds` and `persistent_peers` fields in the config.toml file residing in the node's directory.

```
sh fetch/peers.sh
```

### [state.sh](../fetch/state.sh)

This script fetches the (most recent) `genesis.json` file for the chain-id configured in the [\_variables.sh](../_variables.sh) file and places it inside of the /config-folder residing in the node's directory.

```
sh fetch/state.sh
```
