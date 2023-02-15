// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

// We're gonna do a viaAdminContract. Instead of having an admin address for the proxy contract, we're gonna have the proxy contract owned by an admin contract.
// Doing it this way is considered a best practise for a number of reasons.

contract BoxProxyAdmin is ProxyAdmin {
    constructor(address /* owner */) ProxyAdmin() {
        // And to have our BoxProxyAdmin work with the "hardhat deploy plugin" our constructor needs to take an address owner as an input parameter but we're
        // just gonna leave that blank and then we need to do the ProxyAdmin() which is gonna be blank aswell.
    }
}
