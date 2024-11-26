// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank {
    // Declare an event to log each deposit action
    event DepositMade(address indexed depositor, uint256 amount, uint256 timestamp);

    // Function to allow users to deposit Ether into the piggy bank
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than 0");

        // Emit the event to log this deposit action
        emit DepositMade(msg.sender, msg.value, block.timestamp);
    }
}
