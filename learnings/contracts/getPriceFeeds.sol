

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19 ;

import "./AggregatorV3Interface.sol";
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