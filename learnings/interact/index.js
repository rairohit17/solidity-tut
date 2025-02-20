const {ethers,deployments ,getNamedAccounts} = require("hardhat")
const {deployer} = getNamedAccounts();

 async function main(){
   //  let FundMe = await deployments.fixture(["all"])
    console.log("#####1")
    const transactionDetails = await deployments.get("FundMe"); 
    console.log("#####2")

    FundMe = await ethers.getContractAt("FundMe",transactionDetails.address, deployer)
    console.log("#####3")

    let sendMoney = await FundMe.sendEth({
        value:BigInt("1000000000000000000")
    })
    console.log("#####4")

    const rescipt= await sendMoney.wait();
    console.log("#####5")
    const value = await FundMe.getBalance();
    console.log("transaction sucessfull : ")
    console.log(value);

    console.log("###6")

    const withdrawl = await FundMe.withdraw(value)
    const withdrawlRecipt= await withdrawl.wait();
    console.log("withdrawl successfull , new balance ;" +await FundMe.getBalance() )


 }
 main().catch((error)=>{
    console.log(error);
    process.exit(1);
 })
