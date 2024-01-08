# Setup

## dependencies.sh

This script installs all the dependencies (and system configurations) that are necessary for the binary to run. Since this file already gets called from within the other scripts, it is not required to call this yourself.

## install-service.sh

This script installs the `tgenesisd` service, which will automatically start the node whenever the device reboots (see [tgenesisd.service](/services/tgenesisd.service)). Since this file already gets called from within the other scripts, it is not required to call this yourself.

## shift-ports.sh

This script is useful if you quickly want to replace the ports in the configuration files. It comes from https://github.com/zenodeapp/port-shifter and is slightly adapted for GenesisL1. If you prefer a more simplistic version of the script, use quick-shift.sh found in the aforementioned repository instead.
