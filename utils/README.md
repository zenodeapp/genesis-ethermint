# Utilities

## \_variables.sh

This script holds all the repository-specific variables shared with most of the scripts in the [utils](/utils)-, [setup](/setup)- and [setup-local](/setup-local)-folder. This makes it easier to adjust the chain-id, binary name or node directory without having to change it in a lot of different scripts.

## create-backup.sh

This script creates a backup for the current node-setup, if one existed.

```
sh utils/create-backup.sh [backup_dir_path]
```

> _[backup_dir_path]_ is optional (defaults: to a directory in the $HOME folder with a _unique_ name based on the system's current time).

## create-key.sh

This script creates a _new_ key (or prompts to overwrite one if the _alias_ already exists).

```
sh utils/create-key.sh <key_alias>
```

## fetch-peers.sh

This script fetches the (most recent) seeds and peers list for the chain-id configured in the [\_variables.sh](/utils/_variables.sh) file and adds it to the config.toml file residing in the node's directory. This script leverages the [`genesis-parameters`](https://github.com/zenodeapp/genesis-parameters) repo.

## fetch-state.sh

This script fetches the (most recent) `genesis.json` file for the chain-id configured in the [\_variables.sh](/utils/_variables.sh) file. This script leverages the [`genesis-parameters`](https://github.com/zenodeapp/genesis-parameters) repo.

## import-key.sh

This script imports an _existing_ key using the provided _private Ethereum key_.

```
sh utils/import-key.sh <key_alias> <private_eth_key>
```

## install-service.sh

This script installs the daemon as a service, which will automatically start the node whenever the device reboots (see [genesisd.service](/services/genesisd.service)). The setup scripts usually already call this, therefore it is not required to run this yourself.

## shift-ports.sh

This script is useful if you quickly want to replace the ports in the `config.toml` and `app.toml` files. It uses the script(s) from https://github.com/zenodeapp/port-shifter/tree/v1.0.0. If in doubt whether this is safe, you could always check the repository to see how it works.

```
sh shift-ports.sh <port_increment_value>
```

> <port_increment_value> is how much you would like to increment the value of the ports based on the default port values.
