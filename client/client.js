const client = require('stratum-client');
const { execFile } = require('child_process');
const { MerkleTree } = require('merkletreejs')
const SHA256 = require('crypto-js/sha256')
    

console.log('Connecting to mining pool...')

/*const Client = client({
    server: "btc-us.f2pool.com",
    port: 3333,
    worker: "nectartester.001",
    password: "21235365876986800",
    autoReconnectOnError: true,
    onConnect: () => console.log('Connected to server'),
    onClose: () => console.log('Connection closed'),
    onError: (error) => console.log('Error', error.message),
    onAuthorizeSuccess: () => console.log('Worker authorized'),
    onAuthorizeFail: () => console.log('WORKER FAILED TO AUTHORIZE OH NOOOOOO'),
    onNewDifficulty: (newDiff) => console.log('New difficulty', newDiff),
    onSubscribe: (subscribeData) => console.log('[Subscribe]', subscribeData),
    onNewMiningWork: (newWork) => onWorkRecieved(newWork),
    onSubmitWorkSuccess: (error, result) => console.log("Yay! Our work was accepted!"),
    onSubmitWorkFail: (error, result) => console.log("Oh no! Our work was refused because: " + error),
  });*/

  txids = [
    "3bd3a1309a518c381248fdc26c3a6bd62c35db7705069f59206684308cc237b3",
    "a99011a19e9894753d6c65c8fa412838ea8042886537588e7205734d5de8956d",
  ]


  function onWorkRecieved(newWork) {
    console.log('[New Work]', newWork)

    console.log(SHA256('hello').toString('hex'))

    console.log(SHA256(SHA256('hello')))


    const tree = new MerkleTree(txids, SHA256, {isBitcoinTree: true})
    const root = tree.getRoot().toString('hex')

    MerkleTree.print(tree)


    
  }

  onWorkRecieved(10)