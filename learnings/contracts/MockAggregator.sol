// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19 ;
import "./AggregatorV3Interface.sol";
contract MockAggregator is AggregatorV3Interface{
     int256 public  _currentPrice ;
     constructor(int256 value){
        _currentPrice = value;

     }

      function latestRoundData() 
        external 
        view 
        override 
        returns (
            uint80 roundId, 
            int256 answer, 
            uint256 startedAt, 
            uint256 updatedAt, 
            uint80 answeredInRound
        )
    {
        return (
            1,                  // Round ID
            _currentPrice,       // Latest price (the mock value)
            block.timestamp,    // Started at (current block timestamp)
            block.timestamp,    // Updated at (current block timestamp)
            1                   // Answered in round (static value for simplicity)
        );
    }



}