<div align="center"><h1>Genesis L1 blockchain</h1></div>

<div align="center"><h2>Renaissance, above money & beyond crypto</h2></div>
Genesis L1 is experimental decentralized blockchain project that is powered by top notch open source software to establish decentralized new Layer 1 blockchain for Arts and Science with absolute Ethereum compatibility and Green*!
<br>
<sub>*All Genesis L1 basic blockchain/network infrastructure uses energy from renewable sources: Energy from wind and hydropower!</sub>

<br>

<div align="center"><h2>GENESIS L1 MAINNET:</h2></div>

To connect to Genesis L1 testnet with metamask or other geth compatible software, you can use the following endpoints
+ Network Name: Genesis L1 Testnet
+ New RPC URL: https://rpc.genesisl1.org/
+ Chain ID: 29
+ Currency Symbol (optional): L1
+ Block Explorer URL (optional): https://explorer.genesisl1.org/


+ Additional RPC URL: https://rpcb.genesisl1.org/

<div align="center"><h3>Genesis L1 Mainnet node install script</h3></div>

+ <code>git clone https://github.com/alpha-omega-labs/genesisL1.git </code>
+ <code>cd genesisL1</code>
+ <code>sh mainnet-node.sh mynewnodename</code>

Set your own node name and put it to <strong>mynewnodename</strong>

<div align="center"><h3>Genesis L1 Mainnet validator install script</h3></div>
THIS SCRIPT WILL SETUP YOUR VALIDATOR AUTOMATICALLY WITHOUT SECURITY IN MIND: </br> 
Will install your Genesis L1 Mainnet validator node, sync it, import your Ethereum private key and create validator with specified amount of self staked L1 coins and specified validator commission.</br>


+ <code>git clone https://github.com/alpha-omega-labs/genesisL1.git </code>
+ <code>cd genesisL1</code>
+ <code>sh mainnet-validator.sh mynewnodename ETHEREUM-PRIVATE-KEY amount commission</code>

*ETHEREUM-PRIVATE-KEY is a private key from your Ethereum address (public key) where your L1 are stored. </br>
<strong>!!!USE NEW SEPARATE KEY FOR L1!!! </strong>
</br>
amount must be specified in minimal coin units (aphoton, like wei in Ethereum): </br>

1 L1 = 1 000 000 000 000 000 000 aphoton
</br>
comission rate must be specified in range from 0.01 to 0.99, where 0.01 = 1% and 0.99 = 99%, for example if you want commission rate = 5%, it should be specified as 0.05 in script
Example of starting validator node with 10000L1 staked with private key from address where 100001L1 are stored with 10% validator commission rate:</br>
<code>sh validator.sh pepe 9bb98bc160504838542d40366f731dcb765e1c0c7f19847b4ccd65f35f229747 10000000000000000000000 0.1</code>


<div align="center"><h2>GENESIS L1 TESTNET:</h2></div>

To connect to Genesis L1 testnet with metamask or other geth compatible software, you can use the following endpoints
+ Network Name: Genesis L1 Testnet
+ New RPC URL: https://testrpc.genesisl1.org/
+ Chain ID: 26
+ Currency Symbol (optional): L1
+ Block Explorer URL (optional): https://testnet.genesisl1.org/
 
<div align="center"><h3>Genesis L1 Testnet node install script</h3></div>

+ <code>git clone https://github.com/alpha-omega-labs/genesisL1.git </code>
+ <code>cd genesisL1</code>
+ <code>sh testnet-node.sh mynewnodename</code>

Set your own node name and put it to <strong>mynewnodename</strong>

<div align="center"><h3>Genesis L1 Testnet validator install script</h3></div>
THIS SCRIPT WILL SETUP YOUR VALIDATOR AUTOMATICALLY WITHOUT SECURITY IN MIND: </br> 
Will install your Genesis L1 Testnet validator node, sync it, import your Ethereum private key and create validator with specified amount of self staked L1 coins and specified validator commission.</br>


+ <code>git clone https://github.com/alpha-omega-labs/genesisL1.git </code>
+ <code>cd genesisL1</code>
+ <code>sh testnet-validator.sh mynewnodename ETHEREUM-PRIVATE-KEY amount commission</code>

*ETHEREUM-PRIVATE-KEY is a private key from your Ethereum address (public key) where your L1 are stored. </br>
<strong>!!!USE NEW SEPARATE KEY FOR L1!!! </strong>
</br>
amount must be specified in minimal coin units (aphoton, like wei in Ethereum): </br>

1 L1 = 1 000 000 000 000 000 000 aphoton
</br>
comission rate must be specified in range from 0.01 to 0.99, where 0.01 = 1% and 0.99 = 99%, for example if you want commission rate = 5%, it should be specified as 0.05 in script
Example of starting validator node with 10000L1 staked with private key from address where 100001L1 are stored with 10% validator commission rate:</br>
<code>sh validator.sh pepe 9bb98bc160504838542d40366f731dcb765e1c0c7f19847b4ccd65f35f229747 10000000000000000000000 0.1</code>

GENESIS L1 IS EXPERIMENTAL DECENTRALIZED OPEN SOURCE PROJECT, PROVIDED AS IS, WITH NO WARRANTY.
<!--
parent:
  order: false
-->

<div align="center">
  <h1> Evmos </h1>
</div>

<!-- TODO: add banner -->
<!-- ![banner](docs/ethermint.jpg) -->

<div align="center">
  <a href="https://github.com/tharsis/evmos/releases/latest">
    <img alt="Version" src="https://img.shields.io/github/tag/tharsis/evmos.svg" />
  </a>
  <a href="https://github.com/tharsis/evmos/blob/main/LICENSE">
    <img alt="License: Apache-2.0" src="https://img.shields.io/github/license/tharsis/evmos.svg" />
  </a>
  <a href="https://pkg.go.dev/github.com/tharsis/evmos">
    <img alt="GoDoc" src="https://godoc.org/github.com/tharsis/evmos?status.svg" />
  </a>
  <a href="https://goreportcard.com/report/github.com/tharsis/evmos">
    <img alt="Go report card" src="https://goreportcard.com/badge/github.com/tharsis/evmos"/>
  </a>
  <a href="https://bestpractices.coreinfrastructure.org/projects/5018">
    <img alt="Lines of code" src="https://img.shields.io/tokei/lines/github/tharsis/evmos">
  </a>
</div>
<div align="center">
  <a href="https://discord.gg/trje9XuAmy">
    <img alt="Discord" src="https://img.shields.io/discord/809048090249134080.svg" />
  </a>
  <a href="https://github.com/tharsis/evmos/actions?query=branch%3Amain+workflow%3ALint">
    <img alt="Lint Status" src="https://github.com/tharsis/evmos/actions/workflows/lint.yml/badge.svg?branch=main" />
  </a>
  <a href="https://codecov.io/gh/tharsis/evmos">
    <img alt="Code Coverage" src="https://codecov.io/gh/tharsis/evmos/branch/main/graph/badge.svg" />
  </a>
  <a href="https://twitter.com/EvmosOrg">
    <img alt="Twitter Follow Evmos" src="https://img.shields.io/twitter/follow/EvmosOrg"/>
  </a>
</div>

Evmos is a scalable, high-throughput Proof-of-Stake blockchain that is fully compatible and
interoperable with Ethereum. It's built using the [Cosmos SDK](https://github.com/cosmos/cosmos-sdk/) which runs on top of [Tendermint Core](https://github.com/tendermint/tendermint) consensus engine.

**Note**: Requires [Go 1.17+](https://golang.org/dl/)

## Installation

For prerequisites and detailed build instructions please read the [Installation](https://evmos.dev/quickstart/installation.html) instructions. Once the dependencies are installed, run:

```bash
make install
```

Or check out the latest [release](https://github.com/tharsis/evmos/releases).

## Quick Start

To learn how the Evmos works from a high-level perspective, go to the [Introduction](https://evmos.dev/intro/overview.html) section from the documentation. You can also check the instructions to [Run a Node](https://evmos.dev/quickstart/run_node.html).

## Community

The following chat channels and forums are a great spot to ask questions about Evmos:

- [Evmos Twitter](https://twitter.com/EvmosOrg)
- [Evmos Discord](https://discord.gg/trje9XuAmy)
- [Evmos Forum](https://forum.cosmos.network/c/ethermint)
- [Tharsis Twitter](https://twitter.com/TharsisHQ)

## Contributing

Looking for a good place to start contributing? Check out some [`good first issues`](https://github.com/tharsis/evmos/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22).

For additional instructions, standards and style guides, please refer to the [Contributing](./CONTRIBUTING.md) document.

## Careers

See our open positions on [Cosmos Jobs](https://jobs.cosmos.network/project/evmos-d0sk1uxuh-remote/), [Notion](https://tharsis.notion.site), or feel free to [reach out](mailto:careers@thars.is) via email.
