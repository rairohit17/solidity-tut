//SPDX-License-Identifier:MIT

pragma solidity^0.8.19;

contract Deploy{
error notEven(uint256 num);
    uint256 public favourateNum=0 ;
    function updateFavNum(uint256 _num) public  isEven(_num) returns (bool){
        favourateNum=_num;
        return true;

    }
    
    modifier isEven(uint256 num){
        if (num%2==0){
            revert notEven(num);
        }
        _;
    }





    
}
