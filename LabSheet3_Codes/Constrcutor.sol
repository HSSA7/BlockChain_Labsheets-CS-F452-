pragma solidity ^0.8.0;

contract ExampleContract {
    address public owner;

    // Constructor initializes the owner as the deployer's address
    constructor() {
        owner = msg.sender;
    }
}
