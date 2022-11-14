// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./ERC721A.sol";

contract MyNFT is ERC721A, Ownable {
    using Address for address;

    string private baseTokenURI;

    uint256 public constant MAX_SUPPLY = 5;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseTokenURI
    ) ERC721A(_name, _symbol) {
        // version 1
        baseTokenURI = _baseTokenURI;
    }

    function freeMint(address to, uint256 amount) external payable {
        // check if Exceed max total supply
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceed max total upply");
        // mint
        super._safeMint(to, amount);
    }

    function withdraw() external onlyOwner {
        Address.sendValue(payable(_msgSender()), address(this).balance);
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        baseTokenURI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
}
