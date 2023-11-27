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

### scheduled-start.sh
<li>GenesisL1 restart is sheduled on Nov 30, 2023  00:0 0AM; you can start it manually or run automatic script</li>
<li>Make sure your node was <strong>REUPDATED</strong> and is on block height <strong>6751391</strong> </li>
<li>Make sure you have ONLY following peers listed as permanent peers and make sure your addressbook is empty please: </li>
<pre>3985c968899e7344991ba3589c95b0e6a0ce982c@188.165.211.196:26656,2646a043e1f0c766c5b704463a7d811e100ec7f3@158.69.253.120:26656,0d07fb60f8491f4b53a6b58ae0ce60d4c69be506@135.181.183.88:26656,7757fdee74e8d33ecaa63ead16b3564cb9dea258@85.10.200.11:26656,ef7d81eb8db7ad59b4ce30e022c758cee8dc174f@188.165.202.131:26656,673ec772091d7c4e4dc8af7ed00edea4c8d334ac@65.21.196.125:26656,0d8f14bfcd680a471c4c181590b7a6910544115d@188.40.91.228:26656,0936e624c45ff1ac4089856da2beea148ee6c8de@62.171.183.162:26656,af405a6c392b747aa74704ad0ee8585b8ce164b3@37.187.95.163:26656,0f9ad819318bfa9735603736aa4c6265f666a7d9@5.135.143.103:26656,060585a1cc1fa88b4188a2d94de07b518dc188cf@144.91.84.196:26656,62cb81bad72ed77c776c7fec0547b09bdc5ceb22@158.69.253.103:26656,1d07c049908e614f5d00bf64539581178a2a7f0d@192.99.5.180:26656,be81a20b7134552e270774ec861c4998fabc2969@5.189.128.191:26656,70c201d6568e0ddf1ebe105df06b957cbc255a8b@46.4.108.77:26656,1c41828553d7ed77fb778be9c9c48a8070958744@174.138.180.190:61356,ac8056270101705557e14291dc0c98ef4f65c514@65.109.18.209:26656,75525c6609cf1600d62531b0f4bb2dc4a1f81020@187.85.19.63:26656</pre>
<li>Automatic start schedule script that you can <strong>run any time before Nov 30, 2023</strong>; oneliner:</li>
<pre>wget https://raw.githubusercontent.com/alpha-omega-labs/genesisd/reupdate/scheduled-start.sh && sudo sh scheduled-start.sh</pre>

NOTE: On Nov 30 API nodes will be also REUPDATED and might not response requests during that day, please join TG or Discord for any questions and instructions, thank you! 
