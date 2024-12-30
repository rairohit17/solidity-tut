// SPDX-Licence-Identifier:MIT

pragma solidity 0.8.26;

contract SendEth{
       address owner;
      constructor(){
          owner =msg.sender;
      }


     receive() external payable { }
    fallback() external payable { }
         // these functions are required for a contract to be able to recieve eth without the fincin call 
            // ie the money that is directoly send to the contracts address;
    function send() public payable returns(uint256){
        return  uint256(msg.value);
    }
// if you are sending eth with a finction be sure tomark it payable for it te be able to take value ;
    function withdrawinwei( uint256 val ) payable public  isOwner {
        require(val<=address(this).balance , "entered amount is more than contracts balance ");
        (bool success,  )= payable(owner).call{value:val}("");
        require(success, "the transaction was unsuccessful");

    }
    function showBalance() public view returns ( uint256 balance) {
        return address(this).balance;
    }

    modifier  isOwner()  {
        require(msg.sender==owner,"only owners can withdraw from the contract"); 
        _;
    }




}
