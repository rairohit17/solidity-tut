const { HARDHAT_NETWORK_SUPPORTED_HARDFORKS } = require("hardhat/internal/constants");
require('dotenv').config()
require("@nomicfoundation/hardhat-verify");

require("@nomicfoundation/hardhat-toolbox"); // Ensure this plugin is installed
require("hardhat-gas-reporter")
require('./tasks/getBlockNo.js')
require("solidity-coverage")
// solidity coverage gives the coverage of the tests for the smart contract it tell us which parts of contract have test and which does not 

const SEPILIA_RPC_URL = process.env.RPC_URL_SEPOLIA
const privateKey = process.env.PRIVATE_KEY
// 0xe769828C8184eEa8187bd56AB55D79359e0B2E66
module.exports = {
  networks:{
    sepolia:{
       url : SEPILIA_RPC_URL,
       accounts:[privateKey],
       chainId:11155111,
    },
    localhost:{
      url: "http://127.0.0.1:8545/",
      chainId:31337
    }
  },
  etherscan:{
    apiKey:process.env.API_KEY
  },

  solidity: "0.8.19",
  sourcify :{
    embedded: true
  },
  gasReporter:{
    currency : "INR",
  
  }
};
