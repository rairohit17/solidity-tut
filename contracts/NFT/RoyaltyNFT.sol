    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.20

    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
    import "@openzeppelin/contracts/interfaces/IERC2981.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract RoyaltyNFT is ERC721URIStorage, IERC2981, Ownable {
        struct RoyaltyInfo {
            address recipient;
            uint96 amount;  // the royalty amount to be recieved by the creaator of the nft 
        }

        mapping(uint256 => RoyaltyInfo) private _royalties;
        mapping(uint256 => address) private _creators; 

        uint96 public defaultRoyalty = 500; // default royalty 5 % 

        constructor() ERC721("RoyaltyNFT", "RNFT") {}

        function mintNFT(address to, uint256 tokenId, string memory uri) external {
            _mint(to, tokenId);
            _setTokenURI(tokenId, uri);
            _creators[tokenId] = to; 
            _royalties[tokenId] = RoyaltyInfo(to, defaultRoyalty);
        }

        function royaltyInfo(uint256 tokenId, uint256 salePrice)
            external
            view
            override
            returns (address receiver, uint256 royaltyAmount)
        {
            RoyaltyInfo memory royalty = _royalties[tokenId];
            receiver = royalty.recipient;
            royaltyAmount = (salePrice * royalty.amount) / 10000; 
        }

        function setRoyalty(uint256 tokenId, address recipient, uint96 amount) external {
            require(_creators[tokenId] == msg.sender, "Only creator can set royalty");
            require(amount <= 10000, "Royalty cannot exceed 100%");
            _royalties[tokenId] = RoyaltyInfo(recipient, amount);
        }

        function supportsInterface(bytes4 interfaceId) public view override(ERC721, IERC165) returns (bool) {
            return interfaceId == type(IERC2981).interfaceId || super.supportsInterface(interfaceId);
        }
    }
