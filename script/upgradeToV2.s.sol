// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ERC20V1} from "../src/ERC20V1.sol";
import {ERC20V2} from "../src/ERC20V2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract upgradeToV2 is Script {
    ERC20V2 public tokenV2;

    //address  contractProxy = 0x3f04e120907c8ae03B40fC9f9af7f0968aACBC94;
    address proxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

    function run() public {
        vm.startBroadcast();
        tokenV2 = new ERC20V2();
        ERC20V1(payable(proxy)).upgradeToAndCall(address(tokenV2), "");
        ERC20V2(proxy).initialize();
        vm.stopBroadcast();
        console.log("ERC20V2 Upgrade", proxy);
    }
}
