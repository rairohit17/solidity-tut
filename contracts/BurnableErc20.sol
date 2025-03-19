// SPDX-Licence-Identifier:MIT

pragma solidity 0.8.24;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

 // An erc 20 token  contract which burns 1 percent of the transferred token , reducing token amount and increasing price over time 
contract AutoBurnToken is ERC20, ERC20Burnable, Pausable, Ownable {
    uint256 public burnRate = 1; // 

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override whenNotPaused {
        uint256 burnAmount = (amount * burnRate) / 100; 
        uint256 transferAmount = amount - burnAmount; 

        super._burn(sender, burnAmount); 
        super._transfer(sender, recipient, transferAmount); 
    }

    function pause() external onlyOwner {
        _pause(); 
    }

    function unpause() external onlyOwner {
        _unpause(); 
    }

    function setBurnRate(uint256 newBurnRate) external onlyOwner {
        require(newBurnRate <= 5, "Burn rate too high!"); // setting max burn rate to 5 % to avoid excessive burning of tokens 
        burnRate = newBurnRate;
    }
}

