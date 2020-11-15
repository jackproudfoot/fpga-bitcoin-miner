const SerialPort = require('serialport')

const path = '/dev/tty.usbserial-00001014B'

const port = new SerialPort(path, {baudRate: 115200})

const blockHeader = '';
const blockHeaderBuffer = Buffer.from(blockHeader, 'hex')

port.on('error', (err) => {
    console.log(err)
})

port.on('data', (data) => {
    console.log('Data: ', data)
    
    port.write(blockHeaderBuffer)
})