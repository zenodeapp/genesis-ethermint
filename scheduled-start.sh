#!/bin/bash

timestamp=$(date -d "@1701302400" +%Y%m%d%H%M.%S)

sudo apt-get install -y at

sed -i 's/^halt-height = .*/halt-height = 0/g' ~/.genesisd/config/app.toml
sed -i 's/^pex = .*/pex = false/g' ~/.genesisd/config/config.toml
sed -i 's/^max_num_inbound_peers = .*/max_num_inbound_peers = 0/g' ~/.genesisd/config/config.toml
sed -i 's/^seeds = .*/seeds = ""/' ~/.genesisd/config/config.toml
sed -i 's/^persistent_peers = .*/persistent_peers = "3985c968899e7344991ba3589c95b0e6a0ce982c@188.165.211.196:26656,2646a043e1f0c766c5b704463a7d811e100ec7f3@158.69.253.120:26656,0d07fb60f8491f4b53a6b58ae0ce60d4c69be506@135.181.183.88:26656,7757fdee74e8d33ecaa63ead16b3564cb9dea258@85.10.200.11:26656,ef7d81eb8db7ad59b4ce30e022c758cee8dc174f@188.165.202.131:26656,673ec772091d7c4e4dc8af7ed00edea4c8d334ac@65.21.196.125:26656,0d8f14bfcd680a471c4c181590b7a6910544115d@188.40.91.228:26656,0936e624c45ff1ac4089856da2beea148ee6c8de@62.171.183.162:26656,af405a6c392b747aa74704ad0ee8585b8ce164b3@37.187.95.163:26656,0f9ad819318bfa9735603736aa4c6265f666a7d9@5.135.143.103:26656,060585a1cc1fa88b4188a2d94de07b518dc188cf@144.91.84.196:26656,62cb81bad72ed77c776c7fec0547b09bdc5ceb22@158.69.253.103:26656,1d07c049908e614f5d00bf64539581178a2a7f0d@192.99.5.180:26656,be81a20b7134552e270774ec861c4998fabc2969@5.189.128.191:26656,70c201d6568e0ddf1ebe105df06b957cbc255a8b@46.4.108.77:26656,1c41828553d7ed77fb778be9c9c48a8070958744@174.138.180.190:61356,ac8056270101705557e14291dc0c98ef4f65c514@65.109.18.209:26656,75525c6609cf1600d62531b0f4bb2dc4a1f81020@187.85.19.63:26656"/' ~/.genesisd/config/config.toml
sed -i 's/^unconditional_peer_ids = .*/unconditional_peer_ids = "3985c968899e7344991ba3589c95b0e6a0ce982c,2646a043e1f0c766c5b704463a7d811e100ec7f3,0d07fb60f8491f4b53a6b58ae0ce60d4c69be506,7757fdee74e8d33ecaa63ead16b3564cb9dea258,ef7d81eb8db7ad59b4ce30e022c758cee8dc174f,673ec772091d7c4e4dc8af7ed00edea4c8d334ac,0d8f14bfcd680a471c4c181590b7a6910544115d,0936e624c45ff1ac4089856da2beea148ee6c8de,af405a6c392b747aa74704ad0ee8585b8ce164b3,0f9ad819318bfa9735603736aa4c6265f666a7d9,060585a1cc1fa88b4188a2d94de07b518dc188cf,62cb81bad72ed77c776c7fec0547b09bdc5ceb22,1d07c049908e614f5d00bf64539581178a2a7f0d,be81a20b7134552e270774ec861c4998fabc2969,70c201d6568e0ddf1ebe105df06b957cbc255a8b,1c41828553d7ed77fb778be9c9c48a8070958744,ac8056270101705557e14291dc0c98ef4f65c514,75525c6609cf1600d62531b0f4bb2dc4a1f81020"/' ~/.genesisd/config/config.toml

cd /etc/systemd/system
rm -r genesisd.service
wget https://raw.githubusercontent.com/alpha-omega-labs/genesisd/noobdate/genesisd.service
systemctl daemon-reload

echo 'systemctl enable genesisd; systemctl start genesisd' | at -t $timestamp
