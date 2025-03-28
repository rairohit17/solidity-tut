//SPDX-License-Identifier:MIT

pragma solidity^0.8.19;

import "./AggregatorV3Interface.sol";
import "./getPriceFeeds.sol";

error valueIsLessThanMinUsd();
error notOwner();
error largeValueWithdraw();
contract FundMe {
    using PriceFeeds for int256;
    
    address private immutable owner;
    int256  public constant minimumUsd=50;
    uint256 private bal;
    address private immutable  ethUsdPriceFeedAddress;
    mapping( address=>uint256) public usersWithAmountFunded;
    address[] public funders ;

    
    
    constructor(address priceAddress) {
        owner = msg.sender;
        ethUsdPriceFeedAddress= priceAddress;

        bal= 0;
    }

    receive() external payable {
        sendEth();
     }
     fallback() external payable { 
        sendEth();
     }

     
    function getAllFunders() public  view returns(  address[] memory){
        return funders;
    }
    
    function sendEth() public payable {
        uint256 sendValue= msg.value;
        if(minimumUsd.getPriceOfEth(ethUsdPriceFeedAddress)>int256(msg.value)) {
            revert valueIsLessThanMinUsd();
        }
        
        bal = bal+sendValue;
        if (findFunder(msg.sender)){
           usersWithAmountFunded[msg.sender] = usersWithAmountFunded[msg.sender]+sendValue;

        }
        else{

            usersWithAmountFunded[msg.sender]= sendValue;
            funders.push(msg.sender);
        }
       
    }
    

    function findFunder(address sender)internal view returns(bool){
        for( uint256 i =0; i< funders.length;i++){
            if(funders[i]== sender){
                return true;
            }
        } 
        return false;

    }

    function withdraw(uint256 val) public  isOwner() {
        if ( val>address(this).balance) revert largeValueWithdraw();
        (bool success,) = payable(owner).call{value:val}("");
        require(success,"transaction was unsuccessful");
        bal= bal-val;


    }

    modifier isOwner(){
        if ( msg.sender!= owner){
            revert notOwner();
        }
        _;
    }
    function getBalance() public view returns(uint256){ return bal;
    }
  


}
