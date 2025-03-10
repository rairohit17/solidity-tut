// Sources flattened with hardhat v2.22.18 https://hardhat.org

// SPDX-License-Identifier: MIT

// File contracts/AggregatorV3Interface.sol

// Original license: SPDX_License_Identifier: MIT
pragma solidity ^0.8.0;

interface AggregatorV3Interface {
    
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}



library PriceFeeds{
    

    function getConversionRate(address ethUsdPriceFeedAddress) public view returns(int256){
        AggregatorV3Interface priceFeeds= AggregatorV3Interface(ethUsdPriceFeedAddress);
        (, int256 price,,,)= priceFeeds.latestRoundData();
        return price;


    }
    function getPriceOfEth(int256 value , address ethUsdPriceFeedAddress) internal view returns(int256){
        int256 valueOfEth= getConversionRate(ethUsdPriceFeedAddress)/10e7;
        value = value*10e17;
        int256 ethAmount= value/valueOfEth;
        return ethAmount;
        
    }




}





error valueIsLessThanMinUsd();
error notOwner();
error largeValueWithdraw();
contract FundMe {
    using PriceFeeds for int256;
    
    address public immutable owner;
    int256  internal minimumUsd=3000;
    uint256 public bal;
    address public ethUsdPriceFeedAddress;
    mapping( address=>uint256) public usersWithAmountFunded;
    address[]  funders ;

    
    
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
  


}
