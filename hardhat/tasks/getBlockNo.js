const{task} = require("hardhat/config");
// import { networks } from "../hardhat.config";
// const {networks}= require("../hardhat.config")

task("get-block","get the current block number").setAction(
    async(taskArgs , hre)=>{
        const  provider= await hre.ethers.provider;
        const blockNum= await provider.getBlockNumber();
        console.log("current block number : "+blockNum)
    }
)

task ("get-balance","get balance on a particular network").addParam("address","add address").setAction(
    async(args,hre)=>{
        const address = await args.address;
        const balance = await hre.ethers.provider.getBalance(address);
        console.log(`the balance of ${hre.network.name} is ${balance}`)
    }
)


