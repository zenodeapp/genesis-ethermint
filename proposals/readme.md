# Proposals

## validator-gift-proposal.json

A template for a spending type proposal for Genesis L1 validators gift of 50,000 L1 coins from the community pool. It may be edited and submitted on chain with the tgenesisd daemon/client. After editing the file with a proposal title, description and recipient, genesis-validator-gift-proposal.json may be submitted with the following command:

```
tgenesisd tx gov submit-proposal community-pool-spend genesis-validator-gift-proposal.json
```
