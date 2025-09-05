// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Policy.sol";

contract PolicyTest is Test {
    Policy policy;
    address alice = address(0x1);
    address bob = address(0x2);

    function setUp() public {
        policy = new Policy(alice);
    }

    function testOwnerIsAlice() public view {
        assertEq(policy.owner(), alice);
    }

    function testChangeOwner() public {
        vm.prank(alice);
        policy.setOwner(bob);
        assertEq(policy.owner(), bob);
    }

    function testExec() public {
        // Dummy contract for testing
        Dummy d = new Dummy();

        vm.prank(alice);
        policy.exec(address(d), 0, abi.encodeWithSignature("ping()"));

        assertTrue(d.pinged());
    }
}

contract Dummy {
    bool public pinged;

    function ping() external {
        pinged = true;
    }
}
