const crypto = require('crypto');

function generateRandomString(length) {
    // Create a buffer to store the random bytes
    const buffer = crypto.randomBytes(Math.ceil(length / 2));
    // Convert the buffer to a hexadecimal string
    return buffer.toString('hex').slice(0, length);
  }


function generateID(){
    const rand = crypto.randomInt(20,30);
    const id = generateRandomString(rand) ;
    return id;
}

module.exports = {generateID}