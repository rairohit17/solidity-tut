// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

const { ethers } = require("hardhat");



async function main(){
    console.log("deploying contract")
  const simpleStorageFactory= await ethers.getContractFactory("Lock")
  const deployContract= await simpleStorageFactory.deploy();
  const rescipt = await deployContract.waitForDeployment();
//   await deployContract.deployed();
//   await deployedContract.wait(6)
  console.log("deployed contract at address : " + await rescipt.getAddress())
  const contractAddress = await rescipt.getAddress();
  const abi = simpleStorageFactory.interface.formatJson()
  const [signer] = await ethers.getSigners();
  
  const contract = new ethers.Contract(contractAddress,abi, signer );
  const favNum= await contract.favourateNum();

  console.log("favNum: "+ favNum)

}
main().then(()=>{
    console.log("exiting ...")
    return process.exit(0)
}).catch((err)=>{
    console.log(err)
})
