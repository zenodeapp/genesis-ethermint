<h1> GenesisL1 update (noobdate) to Neolithic stage. Block 2000000.</h1>
<li> genesis_29-1 blockchain state will be exported on 1999999 block height.
<li> block #2000000 should be minted on genesis_29-2 blockchain with genesis_29-1 imported state with adjustments

<h2>Update procedure:</h2>
<li> to update your node (validator) first <strong>halt</strong> your genesis_29-1 network on any chain height prior 1990000
<li> <strong>stop</strong> your node when you see the 2000000 block height and run update.sh script in genesisd repository:
sh update.sh 

 <h2>Easy update, step-by-step:</h2>
<li> Login via ssh to the root user of your node (validator)
<li> Stop node by any way you want, for example by performing the following command if you have genesis as a service:
service genesis stop 
<li> git clone genesisd source code:
<br>git clone https://github.com/alpha-omega-labs/genesisd.git
<br>cd genesisd
<li>Start update: <br>
sh update.sh
<li> Check the updated node status: <br> service genesisd status
