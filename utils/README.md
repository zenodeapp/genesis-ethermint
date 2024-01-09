# Utilities

## install-service.sh

This script installs the `genesisd` service, which will automatically start the node whenever the device reboots (see [genesisd.service](/services/genesisd.service)). Since this file already gets called from within the other scripts, it is not required to call this yourself.

## shift-ports.sh

This script is useful if you quickly want to replace the ports in the configuration files. It uses the script(s) from https://github.com/zenodeapp/port-shifter. If in doubt whether this is safe, you could always check the repository to see how they work.

```
sh shift-ports.sh <port_increment_value>
```
> <port_increment_value> is how much you would like to increment the value of the ports based on the default port values.