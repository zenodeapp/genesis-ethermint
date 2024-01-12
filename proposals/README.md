# Proposals

## validator-gift-proposal.json

A template for a spending type proposal for Genesis L1 validators gift of 50,000 L1 coins from the community pool. It may be edited and submitted on chain with the tgenesisd daemon/client. After editing the file with a proposal title, description and recipient, genesis-validator-gift-proposal.json may be submitted with the following command:

```
tgenesisd tx gov submit-proposal community-pool-spend genesis-validator-gift-proposal.json
```

## plan-cronos.sh

For testing purposes only. A script that makes it easier to send out the 'plan_cronos' upgrade proposal and vote 'yes' on it.

```
sh proposals/plan-cronos.sh <key_alias> <upgrade_height> [next_proposal_id]
```

> _next_proposal_id_ is optional but should point towards the upgrade proposal to vote yes on (default: 1)
