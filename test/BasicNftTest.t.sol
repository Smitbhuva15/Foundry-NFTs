// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test} from 'forge-std/Test.sol';
import { DeployBasicNft} from '../script/DeployBasicNft.s.sol';
import {BasicNft}  from '../src/BasicNft.sol';

contract BasicNftTest is Test{
    DeployBasicNft deploybasicNft;
    BasicNft basicNft;
    address  private immutable USER=makeAddr("user");


   string constant private ACTUAL_NAME="Dogie";

 string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deploybasicNft=new DeployBasicNft();
        basicNft=deploybasicNft.run();

    }

    function testContractName() public view{
           string memory name=basicNft.name();
           assertEq(abi.encodePacked(name),abi.encodePacked(ACTUAL_NAME));
        //    or
        //    assert(keccak256(abi.encodePacked(basicNft.name())) == keccak256(abi.encodePacked((ACTUAL_NAME))));
    }

    function testCanMintAndHaveABalance() public{
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER)==1);
    }
    
    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assertEq(abi.encodePacked(basicNft.tokenURI(0)),abi.encodePacked(PUG_URI));
    }

}
