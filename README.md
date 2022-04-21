<h2>GenesisL1 fast installation scripts</h2>
root user, tested on clean Ubuntu 20.04 LTS
<h3>Update genesis_29-1 to genesis_29-2:</h3>
<code>sh update.sh</code>

<h3>Install genesis_29-2 full node (suitable for validator):</h3>
<code>sh genesisd-node.sh $YOUR_NEW_NODE_NAME</code>

<h3>Install genesis_29-2 full node with EVM RPC-API enabled (not suitable for validator):</h3>
<code>sh genesisd-rpc-node.sh $YOUR_NEW_NODE_NAME</code>
