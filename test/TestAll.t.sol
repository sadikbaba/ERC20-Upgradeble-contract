// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";
import {ERC20V1} from "../src/ERC20V1.sol";
import {ERC20V2} from "../src/ERC20V2.sol";
import {DeployV1} from "../script/DeployV1.s.sol";
import {upgradeToV2} from "../script/upgradeToV2.s.sol";

contract testAll is Test {
    function setUp() public {}
}
