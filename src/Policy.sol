// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Minimal 7702-Ready Policy Contract
/// @notice Turns an EOA into a minimal smart wallet with owner & exec
contract Policy {
    address public owner;

    event Executed(
        address indexed target,
        uint256 value,
        bytes data,
        bytes result
    );
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    /// @notice Execute arbitrary calls from this wallet
    function exec(
        address target,
        uint256 value,
        bytes calldata data
    ) external onlyOwner returns (bytes memory) {
        (bool success, bytes memory result) = target.call{value: value}(data);
        require(success, "Call failed");
        emit Executed(target, value, data, result);
        return result;
    }

    /// @notice Change the owner (social recovery possible if implemented)
    function setOwner(address newOwner) external onlyOwner {
        emit OwnerChanged(owner, newOwner);
        owner = newOwner;
    }

    /// @notice Accept ETH deposits
    receive() external payable {}
}
