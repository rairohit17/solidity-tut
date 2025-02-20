require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ignition-ethers")
require("dotenv").config()


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks:{
    hardhat:{
        chainId:31337,

    },
    sepolia:{
      chainId:11155111,
      url:process.env.SEPOLIA_INFURA_URL,
      accounts:[process.env.SEPOLIA_ACCOUNT_PRIVATE_KEY]
    },
    localhost:{
      chainId:31337,
      url:"http://127.0.0.1:8545/"
    }
    
  },
  namedAccounts:{
    deployer:{
      default:0
    },
    otherAccount:{
      default:1
    }
  },
  etherscan:{
    apiKey:process.env.ETHERSCAN_API_KEY
  },
  gasReporter:{
    enabled:true,
    currency:"USD",
    noColors:true,
    outputFile:"gas-reporter.txt",
    token:"MATTIC"
  }
};
