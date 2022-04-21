<h2>GenesisL1 fast installation scripts</h2>
root user, tested on clean Ubuntu 20.04 LTS </br>
<h3>Update genesis_29-1 to genesis_29-2:</h3>
<code>sh update.sh</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh update.sh</pre>

<h3>Install genesis_29-2 full node (suitable for validator):</h3>
$YOUR_NEW_NODE_NAME should be changed to any node name you like.</br>
<code>sh genesisd-node.sh $YOUR_NEW_NODE_NAME</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh genesisd-node.sh $YOUR_NEW_NODE_NAME</pre>

<h3>Install genesis_29-2 full node with EVM RPC-API enabled (not suitable for validator):</h3>
$YOUR_NEW_NODE_NAME should be changed to any node name you like.</br>
<code>sh genesisd-rpc-node.sh $YOUR_NEW_NODE_NAME</code></br>
full command on clean new machine with installed git:</br>
<pre>sudo swapoff -a; git clone https://github.com/alpha-omega-labs/genesisd.git; cd genesisd; sh genesisd-rpc-node.sh $YOUR_NEW_NODE_NAME</pre>

<h3>Create validator of genesis_29-2 </h3>
<strong>With imported Ethereum private key, with some L1 coins belonging to that key. Start after the genesisd-node.sh and full sync!</strong>
