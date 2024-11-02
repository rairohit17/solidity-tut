// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./storageContract.sol";

contract multiStorageContract{

StorageContract[] public  storageContractArray ;

//   function to deplay a contract from anothere contract ;
function newStorageContract() public {

    StorageContract  storageContract= new StorageContract();
    
    storageContractArray.push(storageContract);

}
function updateFavourateNum(uint _index , uint _number) public {
    StorageContract storageContract = storageContractArray[_index];
    storageContract.newFavourateNum(_number);

}
function showFavourateNum(uint  _index) public view returns(uint) {
    StorageContract storageContract = storageContractArray[_index];
    return storageContract.FavourateNum();
    
    
}



}