const {run} = require("hardhat")

module.exports = async function verifyFundMe(contractAddress , constructorArguments){
    try{
        console.log("verifying contracts")
        await run("verify:verify",{
            address:contractAddress,
            constructorArguments:constructorArguments,
        })
        console.log("contract verified successfully")
        
    }
    catch(err){
        if (err.message.toLowerCase().includes("already verified")){
            console.log("contract already verified");

        }
        else{
            console.log("verification failed : "+ err)
        }
    }


}