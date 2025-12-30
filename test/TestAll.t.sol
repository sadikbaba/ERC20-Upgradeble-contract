// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {ERC20V1} from "../src/ERC20V1.sol";
import {ERC20V2} from "../src/ERC20V2.sol";

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract testAll is Test {
    ERC20V1 token;
    ERC20V2 tokenV2;
    ERC1967Proxy proxy;

    //  address owner = address(2);
    address notOwner = address(3);

    function setUp() public {
        token = new ERC20V1();
        tokenV2 = new ERC20V2();
        proxy = new ERC1967Proxy(address(token), "");
        ERC20V1(address(proxy)).initialize();
    }

    function testVersionOfV1() public view {
        uint256 expectedVersion = 1;
        uint256 actualVersion = ERC20V1(address(proxy)).version();
        assertEq(expectedVersion, actualVersion);
    }

    function testMint() public {
        uint256 mintAmount = 5e18;
        address owner = ERC20V1(address(proxy)).owner();
        uint256 totalMintedBefore = ERC20V1(address(proxy)).balanceOf(owner);
        console.log("totalMintedBefore", totalMintedBefore);
        assertEq(0, totalMintedBefore);
        vm.prank(owner);
        ERC20V1(address(proxy)).mint(mintAmount);
        uint256 totalMintedAfter = ERC20V1(address(proxy)).balanceOf(owner);
        console.log("totalMintedAfter", totalMintedAfter);
        assertEq(mintAmount, totalMintedAfter);
    }

    function testMintNotInitOwner() public {
        vm.prank(notOwner);
        uint256 mintAmount = 5e18;
        vm.expectRevert();
        ERC20V1(address(proxy)).mint(mintAmount);
    }

    function testCallInitAfterWasInitialized() public {
        vm.expectRevert();
        ERC20V1(address(proxy)).initialize();
    }

    // test Upgrade to v2.

    function testUpgradeToV2() public {
        uint256 mintAmount = 10e18;
        uint256 burnAmount = 5e18;
        address ownerV1 = ERC20V1(address(proxy)).owner();

        ERC20V1(payable(proxy)).upgradeToAndCall(address(tokenV2), "");
        vm.expectRevert();
        ERC20V2(address(proxy)).initialize(); // expect revert we already assign owner in v1

        address ownerV2 = ERC20V2(address(proxy)).owner();
        assertEq(ownerV1, ownerV2);

        console.log("ownerV1", ownerV1);
        console.log("ownerV2", ownerV2);

        vm.prank(ownerV2);

        ERC20V2(address(proxy)).mint(mintAmount);
        ERC20V2(address(proxy)).burn(burnAmount);
        
        uint256 owner2BalanceAfter = ERC20V2(address(proxy)).balanceOf(ownerV2);
        console.log("owner balance after:", owner2BalanceAfter);
        assertEq(owner2BalanceAfter, mintAmount - burnAmount);
    }
}
