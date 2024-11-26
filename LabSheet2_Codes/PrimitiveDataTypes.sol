// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimitiveDataTypes {
    // Boolean: Can be true or false
    bool public isActive = true;

    // Integer (signed int): Stores positive and negative integers
    int public temperature = -15;

    // Unsigned Integer (uint): Stores only positive integers
    uint public totalSupply = 1000;
    uint8 public smallUint = 255; // uint8 ranges from 0 to 255

    // Address: Holds Ethereum addresses (20 bytes)
    address public owner = msg.sender;

    // Byte Fixed Array: Stores a fixed number of bytes
    bytes1 public smallByte = 0x01; // Single byte (byte)
    bytes32 public largeByte = 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;

    // String: Stores a sequence of characters
    string public greeting = "Hello, Solidity!";

    // Enum: Custom type with fixed possible values
    enum Status { Pending, Shipped, Delivered }
    Status public orderStatus = Status.Pending;

    // Function to demonstrate usage
    function updateData() public {
        isActive = !isActive;            // Toggling the boolean
        temperature += 10;              // Modifying signed integer
        totalSupply += 500;             // Modifying unsigned integer
        orderStatus = Status.Shipped;   // Updating Enum value
    }
}
