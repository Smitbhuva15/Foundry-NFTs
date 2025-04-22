// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    enum NFTState { 
        HAPPY,
        SAD
    }
  
  error  MoodNft__CantFlipMoodIfNotOwner();

    uint256 s_TokenCounter = 0;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    mapping(uint256 => NFTState) private s_tokenIdToState;

    constructor(
        string memory s_sadsvgImageuri,
        string memory s_happysvgImageuri
    ) ERC721("Mood NFT", "MN") {
        s_TokenCounter = 0;
        s_sadSvgImageUri = s_sadsvgImageuri;
        s_happySvgImageUri = s_happysvgImageuri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_TokenCounter);
        s_tokenIdToState[s_TokenCounter] = NFTState.HAPPY;
        s_TokenCounter++;
    }

 function FlipMood(uint256 tokenId) public {
       
        if (getApproved(tokenId)!=msg.sender && ownerOf(tokenId)!=msg.sender) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToState[tokenId] == NFTState.HAPPY) {
            s_tokenIdToState[tokenId] = NFTState.SAD;
        } else {
            s_tokenIdToState[tokenId] = NFTState.HAPPY;
        }
    }


    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory imgUri;
        if (s_tokenIdToState[tokenId] == NFTState.SAD) {
            imgUri = s_sadSvgImageUri;
        } else {
            imgUri = s_happySvgImageUri;
        }

        bytes memory data_json = abi.encodePacked(
            '{"name":"',
            name(),
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imgUri,
            '"}'
        );

        return string(abi.encodePacked(_baseURI(), Base64.encode(data_json)));
    }

    function getHappySVG() public view returns (string memory) {
        return s_happySvgImageUri;
    }

    function getSadSVG() public view returns (string memory) {
        return s_sadSvgImageUri;
    }
}
