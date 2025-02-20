// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// ABsic layout for creating an erc 20 token 

// steps 
// first create a capped and burbnable contract 
// define a cap and you can also burn the tokens if not needed;
// create some miner reward for miners who include that transaction bloack in blockchain 
// in newer versions the update function is called upon caling mint transfer and burn functions therefore update the _update function from 
// the capped erc contract to mint some tokens for th miner 

contract RohitToken is ERC20Capped, ERC20Burnable {  // super.update resolves update function of erc 20 capped
    address payable immutable i_owner;
    uint256 public blockReward  ; 
    constructor(uint256 cap, uint256 _blockReward) ERC20("RohitToken", "RoEth") ERC20Capped(cap * (10 ** decimals())) {
        i_owner = payable(msg.sender);
        blockReward=_blockReward*10e17;
        _mint(i_owner, ((50)*cap)*10e15); // 50 percent of total coins minted 
    }


    function updateBlockReward(uint256 _blockReward) public onlyOwner{
        blockReward = _blockReward*10e17;
    }

    modifier onlyOwner {
        if (msg.sender!=i_owner){
            revert("message sender is not the owner");
        }
        _;
    }

    function mintMinerReward() internal {
        _mint(block.coinbase , blockReward);
    }

    function _update(address from , address to , uint256 value) internal override(ERC20Capped , ERC20 )  {
        if (from != address(0) && to!= block.coinbase && to!= address(0)){
            mintMinerReward();
        }
        super._update(from , to , value );    // insted of overriding update function just used it for calling 

    }
  
}
