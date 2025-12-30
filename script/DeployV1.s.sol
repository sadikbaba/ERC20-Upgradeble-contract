// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {ERC20V1} from "../src/ERC20V1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployV1 is Script {
    ERC20V1 public tokenV1;
    ERC1967Proxy public proxy;

    function run() public {
        vm.startBroadcast();
        tokenV1 = new ERC20V1();
        proxy = new ERC1967Proxy(address(tokenV1), "");
        ERC20V1(address(proxy)).initialize();
        vm.stopBroadcast();
    }
}

