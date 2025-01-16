const {ethers} = require("@nomicfoundation/hardhat-ethers");
// const { deployments } = require("hardhat");
const {network} = require("hardhat");
const {networkConfig,developmentNetworks} = require("../helper-hardhat-config.js")
 const verifyFundMe = require("../utils/verifyFundMe.js")
module.exports = async( hre)=>{
    const {getNamedAccounts, deployments}= hre // hre is automatically injected by the hardhat when we run commands such as run or deploy
                                                    //hre has tools n=and configurations required for interacting with the blockchain 

    const {deployer} = await getNamedAccounts();
    const {deploy} = deployments;
    const chainId = network.config.chainId;
    const chain= network.name;
    // let ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"];
    let confirmationNo = networkConfig[chainId]["waitConfirmations"]


    if (developmentNetworks.includes(chain)){
        // console.log("development network detected , deploying Mock contract : ")
        const mock = await deployments.get("MockAggregator")
        ethUsdPriceFeedAddress = mock.address;
    }
    else{
        ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]
    }
    

    const contract =  await deploy("FundMe",{
        from:deployer,
        log:true,
        args:[ethUsdPriceFeedAddress],
        waitConfirmations:confirmationNo
        
    });
    if ( !developmentNetworks.includes(chain)){
        await verifyFundMe(contract.address,[ethUsdPriceFeedAddress])
        }
    console.log("contract deployed to : " + contract.address)
    console.log("----------------------------------------------------")
    

}

module.exports.tags= ["FundMe"];