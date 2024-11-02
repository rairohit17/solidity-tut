// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract StorageContract{

    uint public  FavourateNum ;

    function newFavourateNum(uint _num) public  {
        FavourateNum=_num;

    }




}