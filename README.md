<h2>GenesisL1 fast installation scripts</h2>
root user, tested on clean Ubuntu 20.04 LTS
$YOUR_NEW_NODE_NAME should be changed to any node name you like.
<h3>Update genesis_29-1 to genesis_29-2:</h3>
<code>sh update.sh</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh update.sh</pre>

<h3>Install genesis_29-2 full node (suitable for validator):</h3>
<code>sh genesisd-node.sh $YOUR_NEW_NODE_NAME</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh genesisd-node.sh $YOUR_NEW_NODE_NAME</pre>

<h3>Install genesis_29-2 full node with EVM RPC-API enabled (not suitable for validator):</h3>
<code>sh genesisd-rpc-node.sh $YOUR_NEW_NODE_NAME</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh genesisd-node-rpc.sh $YOUR_NEW_NODE_NAME</pre>
