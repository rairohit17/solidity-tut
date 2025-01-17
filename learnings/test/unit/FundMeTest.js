const {deployments,getNamedAccounts,ethers}= require("hardhat")
const {assert,expect} = require("chai")
const { bigint } = require("hardhat/internal/core/params/argumentTypes")

describe("FundMe",()=>{
    let fundMe,mockTransaction
    beforeEach(async()=>{
        

        // fundMe= await deployments.deploy("FundMe",{
        //     from:deployer,
            
        // })either do all the stuff again or 

        await deployments.fixture(["all"]) // will deploy all the deploy scripts with all tag present
        const transactionDetails = await deployments.get("FundMe"); 
        const [signer] = await ethers.getSigners()
        // the deployments prop of hardhat deploy is used to tract the deployment status and contains the transaction details 
        fundMe = await ethers.getContractAt("FundMe",transactionDetails.address, signer)
        // the ethers from hardhat is used to create an instance of deployed contracts for accessing the methods of the contract
          mockTransaction = await deployments.get("MockAggregator");
        


    })

    describe("constructor", ()=>{
        it("sets the aggregator address correctly",async()=>{
            if (!fundMe) {
                throw new Error("FundMe contract not initialized")
            }
            let mockAddress= await mockTransaction.address
            let passedAddress =await fundMe.ethUsdPriceFeedAddress()
            assert.equal(passedAddress,mockAddress, "the values are not equal ")
            
        })

    })
    describe("fund",()=>{
        let minEth

        it("reverts if you don't send enough eth" ,async ()=>{
            const mockPrice = BigInt(process.env.MOCK_PRICE);
            let minimumUsd = BigInt(await fundMe.minimumUsd())
             minEth =( minimumUsd / mockPrice) * BigInt(100000000);
            
            // Calculate half of minimum ETH to ensure revert
            const halfMinEth = minEth / BigInt(2);
            
            // Test that transaction reverts
            await expect(
                fundMe.sendEth({ value: halfMinEth })
            ).to.be.reverted;

            
        })
        it("must add funder to funders array", async()=>{
            const {deployer} = await getNamedAccounts()

            

            let ethToBeSend= minEth*BigInt(2);
            let sendEth= await fundMe.sendEth({value:BigInt('1000000000000000000')});
            // console.log(sendEth)
            const fundersArray=  await fundMe.getAllFunders();
            assert.isTrue(fundersArray.includes(sendEth.from),"funder is not added to array ")

            
        })
        it("must add update the  value of bal upon sending etherium", async()=>{
            let balance = await fundMe.bal();
            await fundMe.sendEth({value:BigInt("1000000000000000000")});
            const newBalance= await fundMe.bal();
            const sum= BigInt(balance)+ BigInt("1000000000000000000");
            assert.equal(sum,newBalance,"the bal variable is not updated properly")
        })
        
    })

})
