const {assert,expect} = require("chai");
const {ethers}= require("hardhat")

describe('Lock',()=>{
  let simpleStorageFactory , deployedContract;
  beforeEach(async()=>{
     simpleStorageFactory= await ethers.getContractFactory('Lock');
     deployedContract= await simpleStorageFactory.deploy();
     deployedContract.waitForDeployment();
  })
  it ("should start with 0", async()=>{
    const currentValue = await deployedContract.favourateNumber();
    const expectedValue = "0"
    assert.equal(currentValue.toString(), expectedValue);
  })
   

  it("should only accept odd numbers", async()=>{
    const value = "27"
    const updated = await deployedContract.updateFavNum(parseInt(value));
     const updatedValue = await deployedContract.favourateNumber();
     assert.equal(updatedValue.toString() , value);

  })
  
  it("favourate Number cannot be even", async()=>{
    const value= "236";
    try{
      await deployedContract.updateFavNum(parseInt(value))
      assert.fail("Even value assigned to Favourite Number ")
    }catch(error){
      
      assert( error.message.includes(`notEven(${value})`),"expected custom error notEven() not  found") // first condition is not true then send condition is given as fail reason
    }
  })




})
