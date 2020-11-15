const client = require('stratum-client');
const { MerkleTree } = require('merkletreejs')
const SHA256 = require('crypto-js/sha256')
const CryptoJS = require('crypto-js')
const SerialPort = require('serialport')

const path = '/dev/tty.usbserial-00001014B'

const port = new SerialPort(path, {baudRate: 115200})
    

// BTC Pool
// btc-us.f2pool.com
// 3333

// Profit Switching Pool
// sha256d.f2pool.com
// 6100

console.log('Connecting to mining pool...')

const Client = client({
    server: 'btc-us.f2pool.com',
    port: '3333',
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
  });


function onWorkRecieved(newWork) {
    //console.log('[New Work]', newWork)

    // Load extraNonce data
    extraNonce1 = Buffer.from(newWork.extraNonce1, 'hex')
    extraNonce2 = Buffer.alloc(newWork.extraNonce2Size)
    extraNonce = Buffer.concat([extraNonce1, extraNonce2])

    // Load coinbase tx
    coinb1 = Buffer.from(newWork.coinb1)
    coinb2 = Buffer.from(newWork.coinb2)

    // create complete coinbasetx and hash
    coinbase = Buffer.concat([coinb1, extraNonce, coinb2])
    const coinbase_enc = CryptoJS.enc.Hex.parse(coinbase.toString('hex'))
    const coinbase_tx = SHA256(SHA256(coinbase_enc)).toString(CryptoJS.enc.Hex)

    // prepend coinbase tx to merkle branches
    newWork.merkle_branch.unshift(coinbase_tx)

    // create merkle tree and get the root
    const tree = new MerkleTree(newWork.merkle_branch, SHA256, {isBitcoinTree: true})
    const root = tree.getRoot().toString('hex')
    const reversedRoot = root.match(/../g).reverse().join('')

    // Order the header components
    headerComponents = []
    headerComponents.push(
      newWork.version,
      newWork.prevhash,
      reversedRoot,
      newWork.ntime,
      newWork.nbits,
      '00000000'
    )

    // construct the complete header
    header = headerComponents.join('')


    // calculate target
    target = (26959946667150639794667015087019630673637144422540572481103610249215 / newWork.miningDiff)
    target_hex = target.toString(16)
    
    
    target_buf = Buffer.alloc(32)
    target_buf.write(target_hex, 32 - Math.floor(target_hex.length / 2), 'hex')

      

    console.log('[New Work]')
    console.log('Header: ' + header)
    console.log('Target: ' + target_buf.toString('hex'))
    console.log('Clean jobs:' + newWork.clean_jobs)


    // Write block header to serial port
    port.write(Buffer.from(header, 'hex'))

}

port.on('error', (err) => {
    console.log(err)
})

port.on('data', (data) => {
    console.log('Data: ', data)
})
  

  // Testing on the data from block 125552
  // See: https://en.bitcoin.it/wiki/Block_hashing_algorithm
  // and https://www.blockchain.com/btc/block/125552
  function test() {
    const version = '01000000'
    const hash_prev = '00000000000008a3a41b85b8b29ad444def299fee21793cd8b9e567eab02cd81'
    temp_txs = [
      '51d37bdd871c9e1f4d5541be67a6ab625e32028744d7d4609d0c37747b40cd2d',
      '60c25dda8d41f8d3d7d5c6249e2ea1b05a25bf7ae2ad6d904b512b31f997e1a1',
      '01f314cdd8566d3e5dbdd97de2d9fbfbfd6873e916a00d48758282cbb81a45b9',
      'b519286a1040da6ad83c783eb2872659eaf57b1bec088e614776ffe7dc8f6d01'
    ]
    const time = 'c7f5d74d'
    const bits = 'f2b9441a'
    const nonce = '42a14695'


    const tree = new MerkleTree(temp_txs, SHA256, {isBitcoinTree: true})
    const root = tree.getRoot().toString('hex')

    const hash_prev_le = hash_prev.match(/../g).reverse().join('')
    const merkle_le = root.match(/../g).reverse().join('')

    const header = version + hash_prev_le + merkle_le + time + bits + nonce

    const header_buf = Buffer.from(header, 'hex')


    const header_enc = CryptoJS.enc.Hex.parse(header)

    hash = SHA256(SHA256(header_enc)).toString(CryptoJS.enc.Hex)    

    console.log('header: ' + header)
    console.log('hash:' + hash.match(/../g).reverse().join(''))

  }