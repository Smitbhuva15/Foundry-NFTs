// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

import {MoodNft} from "../src/MoodNft.sol";

contract DeployMoodNft is Script {

    string  sadSvg = vm.readFile("./image/dynamicNft/sad.svg");
    string  happySvg = vm.readFile("./image/dynamicNft/happy.svg");

    function run() external returns (MoodNft) {
        vm.startBroadcast();
       MoodNft moodNft = new MoodNft(filetoSvgCreate(sadSvg),filetoSvgCreate(happySvg));
        vm.stopBroadcast();
        return moodNft;
    }

    function filetoSvgCreate(string memory svg) public pure returns(string memory) {
         
          string memory baseURI = "data:image/svg+xml;base64,";

          string memory svgBase64Encoded=Base64.encode(bytes(string(abi.encodePacked(svg))));

          return string(abi.encodePacked(baseURI,svgBase64Encoded));
    }
}
