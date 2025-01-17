require("@nomicfoundation/hardhat-toolbox");
require ("hardhat-deploy");
require("@nomicfoundation/hardhat-ethers")
// require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers:[
      {
        version:"0.8.19",
      }
    ]
    
  },
  defaultNetwork:"hardhat",
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
  }
};
