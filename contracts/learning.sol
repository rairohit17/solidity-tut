// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// whenever a smart contract is deployed a transaction occurs and after creatinga concensus 
// a new bloc is added to the blockchain 



// In Solidity, if you define a public variable, Solidity automatically
//  creates a getter function for it, allowing you to access the value. 
// But you need to call this function to retrieve the actual value.
// you can call those varibales by traeatinga s a function ();

contract LearningSolidity{
    uint256 public newNum;


    // whenever this function is called a gas fees will be charged as it is changing a state in blockchain
    
    function computation(uint256 data)  public  returns(uint256){
        newNum=data ;
            return newNum;
    }

    // view functions are used just to read a value from the etherium virtual machine 
    // if a view function is called within a transaction then the gas fee equal to
    // estimated fees will be charged 
    function anotherFunction()  public view returns(uint256){
        return newNum;
    }
    // pure functions are the fucntion that perform computation logic they do not change
    // the state of the contract and neither have access to them 
    //  all functions that perfoorms change in state must be included in functions other than 
    // view and pure 
    // view and pure functions are not charged any gas fees as they do not alter blockchain state 
    // 
    function changeVlaue(uint256 input) public pure returns(uint256){
        return input*2 + 342;

    }

}