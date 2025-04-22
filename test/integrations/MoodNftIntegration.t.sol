// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test,console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from '../../script/DeployMoodNft.s.sol';

contract MoodNftTest is Test{
    MoodNft moodnft;
    DeployMoodNft deployMoodNft;
    address USER=makeAddr("user");

    function setUp() public {
      deployMoodNft=new DeployMoodNft();
      moodnft=deployMoodNft.run();
    }

    function testurifunction() public{
           vm.prank(USER);
           moodnft.mintNft();
           console.log(moodnft.tokenURI(0));
    }
}
