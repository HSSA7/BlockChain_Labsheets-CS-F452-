// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // Declare a mapping from address to uint
    mapping(address => uint) public balances;

    // Function to set the balance of a specific address
    function setBalance(uint amount) public {
        balances[msg.sender] = amount; // Set the balance for the sender's address
    }

    // Function to get the balance of a specific address
    function getBalance(address user) public view returns (uint) {
        return balances[user]; // Return the balance for the specified address
    }
}
