// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Policy.sol";

/// @notice Simple deployment script for Policy.sol
contract DeployPolicy is Script {
    function run() external {
        // Load private key from environment (set in .env file)
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy Policy with msg.sender as owner
        Policy policy = new Policy(msg.sender);

        vm.stopBroadcast();

        console2.log("Policy deployed at:", address(policy));
    }
}
