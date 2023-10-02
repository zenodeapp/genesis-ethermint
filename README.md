# GenesisL1 blockchain

<p align="center">
  <img src="https://github.com/zenodeapp/genesisL1/assets/108588903/be368fa2-a154-48a6-b04b-8eb452b02033" alt="GenesisL1" width="150" height="150"/>
</p>

<p align="center">
   Cosmos SDK v0.44.5-patch
</p>

<p align="center">
   <i>Source code fork of evmos and ethermint.</i>
</p>

## Node requirements

- 300GB+ good hard drive disk
- 8GB+ RAM (if necessary it will use at max 150GB from hard drive as swap, see below)
- 4 CPU Threads
- Good Internet Connection

## **Script**


### Overview

`reupdate.sh` is available in the root folder of the repository. Running `sh reupdate.sh` will start reupdate to v0.44.5 of SDK as it was before chain halt.
It will backup your current .genesisd folder, delete it and restore from older backup done during sdk v0.44.5 to 0.46.15 update. You can also change genesisd_backup_* on line 72 https://github.com/alpha-omega-labs/genesisd/blob/7a7b6ba2288d88fc024564f8afa4593f0b2b6f7e/reupdate.sh#L72C13-L72C30 to .evmosd._backup if you have it from older backups. 
### Usage
  `sh reupdate.sh`
