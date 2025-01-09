//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

contract Lock{
  
error notEven(uint256 num);
    uint256 public favourateNumber=189 ;
    function updateFavNum(uint256 _num) public  isEven(_num) returns (bool){
        favourateNumber=_num;
        return true;

    }
    
    modifier isEven(uint256 num){
        if (num%2==0){
            revert notEven(num);
        }
        _;
    }
}


