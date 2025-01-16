const {network } = require("hardhat")
const {networkConfig} = require("../helper-hardhat-config")

module.exports = async (hre)=>{
    const {getNamedAccounts,deployments}= hre 
    const {deployer} = await getNamedAccounts()
    const {deploy} = deployments;
    const  chainId = network.config.chainId;
    console.log("hi")
    const confirmationWait = networkConfig[chainId]["waitConfirmations"]
    console.log("deploying mock")
    const contract = await deploy("MockAggregator",{
        from:deployer,
        args:[40000000],
        log:true,
        // waitConfirmations:confirmationWait
    })
    console.log("contract deployed to : "+ contract.address)
    console.log("----------------------------------------------------")
    
}

