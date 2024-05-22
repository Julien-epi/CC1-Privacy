// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PrivacySolution is Script {

    Privacy public privacyInstance;

    function setUp() public {
        bytes32[3] memory data = [
            keccak256(abi.encodePacked("data1")),
            keccak256(abi.encodePacked("data2")),
            keccak256(abi.encodePacked("data3"))
        ];
        privacyInstance = new Privacy(data);
    }

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32[3] memory data = privacyInstance.data();
        bytes32 key = keccak256(data[2]);
        bytes16 key16 = bytes16(key);
        console.log("Before: ", privacyInstance.locked());
        privacyInstance.unlock(key16);
        console.log("After: ", privacyInstance.locked());
        vm.stopBroadcast();
    }
}