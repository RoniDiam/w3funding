require("@nomiclabs/hardhat-waffle");

const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {
  solidity: "0.8.5",
  networks: {
    arbitrum: {
      url: `https://rinkeby.arbitrum.io/rpc`,
      gasPrice: 0,
      accounts: {mnemonic: mnemonic},
    }
  },
};