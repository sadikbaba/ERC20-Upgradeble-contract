// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20V1 is Initializable, OwnableUpgradeable, UUPSUpgradeable, ERC20Upgradeable {
    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __ERC20_init("ERC20V1", "V1");
    }

    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function version() public pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
