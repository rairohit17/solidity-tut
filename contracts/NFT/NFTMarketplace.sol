// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ReentrancyGuard, Ownable {
    struct Listing {
        address seller;
        uint256 price;
    }

    mapping(address => mapping(uint256 => Listing)) public listings; //  mapping for nft contract mapped to token id which is mapped to listinng

    event NFTListed(address indexed seller, address indexed nftContract, uint256 indexed tokenId, uint256 price);
    event NFTSold(address indexed buyer, address indexed nftContract, uint256 indexed tokenId, uint256 price);
    event NFTDelisted(address indexed seller, address indexed nftContract, uint256 indexed tokenId);

    // listing nft for sale 
    function listNFT(address nftContract, uint256 tokenId, uint256 price) external {
        require(price > 0, "Price must be greater than zero");
        
        IERC721 nft = IERC721(nftContract);
        require(nft.ownerOf(tokenId) == msg.sender, "Not the NFT owner");
        require(nft.getApproved(tokenId) == address(this) || nft.isApprovedForAll(msg.sender, address(this)), "Marketplace not approved");

        listings[nftContract][tokenId] = Listing(msg.sender, price);
        emit NFTListed(msg.sender, nftContract, tokenId, price);
    }

    // buying a nft 
    function buyNFT(address nftContract, uint256 tokenId) external payable nonReentrant {
        Listing memory listedItem = listings[nftContract][tokenId];
        require(listedItem.price > 0, "NFT not listed for sale");
        require(msg.value >= listedItem.price, "Insufficient funds");

        // Handle royalty payments
        uint256 royaltyAmount = 0;
        address royaltyReceiver;

        try IERC2981(nftContract).royaltyInfo(tokenId, listedItem.price) returns (address receiver, uint256 amount) {
            royaltyReceiver = receiver;
            royaltyAmount = amount;
        } catch {
            // if the nft contract does not support royalties then ignore it 
        }

            //   REENTRANCY ATTACKS : a vulnerability in smart contracts where an attacker exploits external calls to repeatedly re-enter a function before the previous execution completes. This allows the attacker to drain funds or manipulate contract state unexpectedly.


        address seller = listedItem.seller;
        delete listings[nftContract][tokenId]; // removing listings before paying for protecting against reentrancy attacks 

        if (royaltyAmount > 0 && royaltyReceiver != address(0)) {
            payable(royaltyReceiver).transfer(royaltyAmount);
        }

        uint256 sellerProceeds = listedItem.price - royaltyAmount;
        payable(seller).transfer(sellerProceeds); 

        IERC721(nftContract).safeTransferFrom(seller, msg.sender, tokenId);

        emit NFTSold(msg.sender, nftContract, tokenId, listedItem.price);
    }

    
    function delistNFT(address nftContract, uint256 tokenId) external {
        require(listings[nftContract][tokenId].seller == msg.sender, "Not the seller");
        delete listings[nftContract][tokenId];
        emit NFTDelisted(msg.sender, nftContract, tokenId);
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
