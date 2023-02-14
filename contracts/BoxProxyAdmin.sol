// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract BoxProxyAdmin is ProxyAdmin {
    constructor(address /* owner */) ProxyAdmin() {
        // And to have our BoxProxyAdmin work with the "hardhat deploy plugin" our constructor needs to take an address owner as an input parameter but we're
        // just gonna leave that blank and then we need to do the ProxyAdmin() which is gonna be blank aswell.
    }
}
