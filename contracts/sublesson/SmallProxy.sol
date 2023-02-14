//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// Tried all this in Remix.
// This is a minimalistic example of how upgrading actually works.

// So, from what I understand so far, one use case that I'll need to use assembly is when I want to interact with specific storage slots!

import "@openzeppelin/contracts/proxy/Proxy.sol";

contract SmallProxy is Proxy {
    // This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
    // This is the storage slot where the implementation address will be stored
    // This implementation slot looks to be saved in another storage slot other than 0, because if it was the delegated contract would override it and I created the
    //getImplementation() to verify that and it always gives the initial value of 0x360894..., and readStorage that reads storage slot 0 gives the delegated contract value.
    bytes32 private constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function setImplementation(address newImplementation) public {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    function _implementation()
        internal
        view
        override
        returns (address implementationAddress)
    {
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    function getImplementation() public pure returns (bytes32) {
        //created by me to confirm that the slot that _IMPLEMENTATION_SLOT variable is saved is not storage 0.
        return _IMPLEMENTATION_SLOT;
    }

    function getDataToTransact(
        uint256 numberToUpdate
    ) public pure returns (bytes memory) {
        return abi.encodeWithSignature("setValue(uint256)", numberToUpdate);
    }

    function readStorage()
        public
        view
        returns (uint256 valueAtStorageSlotZero)
    {
        assembly {
            valueAtStorageSlotZero := sload(0)
        }
    }
}

contract ImplementationA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
}

contract ImplementationB {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue + 2;
    }
}
