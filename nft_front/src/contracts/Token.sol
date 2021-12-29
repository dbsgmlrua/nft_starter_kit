pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Token is ERC721, ERC721Enumerable, Ownable{
    uint256 public maxSupply = 10000; // Amount of max supply
    constructor() ERC721("Simple Nft Token", "SNT") {
        // minttoken();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "<HARD CODED YOUR BASEURL>";
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".json")) : "";
    }
    function createToken () public payable returns (uint) {
        require(totalSupply() < maxSupply, "Sorry, SomethingWrong");
        payable(owner()).transfer(msg.value);
        uint256 newItemId = totalSupply() + 1;
        _mint(msg.sender, newItemId);
        return newItemId;
    }

}