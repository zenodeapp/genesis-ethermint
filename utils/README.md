# Utilities

## _variables.sh

This script holds all the repository-specific variables shared with most of the scripts in the [utils](/utils)- and [setup](/setup)-folder. This makes it easier to adjust the chain-id, binary name or node directory without having to change it in a lot of different scripts.

## fetch-state.sh

This script fetches the (most recent) `genesis.json` file for the chain-id configured in the [_variables.sh](/utils/_variables.sh) file. It uses the [`genesis-parameters`](https://github.com/zenodeapp/genesis-parameters) repo. In this branch it's also possible to fetch an empty genesis.json file by adding the `--empty` flag. This is useful for setting up a local test chain.

## fetch-peers.sh

This script fetches the (most recent) seeds and peers list for the chain-id configured in the [_variables.sh](/utils/_variables.sh) file and adds it to the config.toml file residing in the node's directory. Also leverages the [`genesis-parameters`](https://github.com/zenodeapp/genesis-parameters) repo.

## install-service.sh

This script installs the `tgenesisd` service, which will automatically start the node whenever the device reboots (see [tgenesisd.service](/services/tgenesisd.service)). Since this file already gets called from within the other scripts, it is not required to call this yourself.

## shift-ports.sh

This script is useful if you quickly want to replace the ports in the `config.toml` and `app.toml` files. It uses the script(s) from https://github.com/zenodeapp/port-shifter/tree/v1.0.0. If in doubt whether this is safe, you could always check the repository to see how it works.

```
sh shift-ports.sh <port_increment_value>
```
> <port_increment_value> is how much you would like to increment the value of the ports based on the default port values.