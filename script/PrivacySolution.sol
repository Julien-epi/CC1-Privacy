// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PrivacySolution is Script {
    Privacy public privacyInstance;

    function setUp() public {
        // Deploy the Privacy contract with known data
        bytes32[3] memory data = [
            keccak256(abi.encodePacked("data1")),
            keccak256(abi.encodePacked("data2")),
            keccak256(abi.encodePacked("data3"))
        ];
        privacyInstance = new Privacy(data);
    }

    function run() external {
        // Start the broadcast
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Retrieve the key from the data array
        bytes32 key = privacyInstance.data(2); // Assumes there's a getter function for data array in Privacy contract
        bytes16 key16 = bytes16(key);

        // Unlock the contract
        console.log("Before unlocking: ", privacyInstance.locked());
        privacyInstance.unlock(key16);
        console.log("After unlocking: ", privacyInstance.locked());

        // Stop the broadcast
        vm.stopBroadcast();
    }
}
