const { HARDHAT_NETWORK_SUPPORTED_HARDFORKS } = require("hardhat/internal/constants");
require('dotenv').config()


require("@nomicfoundation/hardhat-toolbox"); // Ensure this plugin is installed

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});
const SEPILIA_RPC_URL = process.env.RPC_URL_SEPOLIA
const privateKey = process.env.PRIVATE_KEY

module.exports = {
  networks:{
    sepolia:{
       url : SEPILIA_RPC_URL,
       accounts:[privateKey],
       chainId:11155111,
    }
  },

  solidity: "0.8.19",
};
