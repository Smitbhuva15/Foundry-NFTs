// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721{

    uint256 s_TokenCounter=0;
    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;

    constructor () ERC721("Dogie","Dog"){
         s_TokenCounter=0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_TokenCounter]=tokenUri;
        _safeMint(msg.sender, s_TokenCounter);
        s_TokenCounter++;
    }

    function tokenURI(uint256 tokenId) public override view returns(string memory){
        return s_tokenIdToUri[tokenId];
    }

}