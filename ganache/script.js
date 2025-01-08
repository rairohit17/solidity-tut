import {ethers} from "ethers"

import fs from "fs"
try{
    const provider = new ethers.JsonRpcProvider("http://127.0.0.1:7545")

const wallet= new ethers.Wallet("0x0aa72bb15049526f5c863168552e27daac5fea55c18ed17e869e9a2a5dcdd4b9",provider );

const abi = JSON.parse(fs.readFileSync("./garbage/blockchain_Deploy_sol_Deploy.abi","utf-8"))
const binary= fs.readFileSync("./garbage/blockchain_Deploy_sol_Deploy.bin", "utf-8")
console.log("deploying contract")
const contractFactory = new ethers.ContractFactory(abi, binary ,wallet )

const deployedContract= await  contractFactory.deploy();
const transactionrescipt=await deployedContract.deploymentTransaction().wait(1);
console.log("contract deployed at adddress "+await deployedContract.getAddress())

// you n eed to create an instance of  the contract with the help of contract address 
const contract = new ethers.Contract(await deployedContract.getAddress(),abi,wallet)
 console.log("contract instance created ")
//  const rescipt= await contract.getDeploymentTransaction().wait(1)

let favNum = await  contract.updateFavNum(23);
await favNum.wait(1);
console.log( await contract.favourateNum());
process.exit(0);

}catch(err){
    console.log(err)
}
 


