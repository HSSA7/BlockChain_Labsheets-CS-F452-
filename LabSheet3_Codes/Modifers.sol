pragma solidity ^0.8.0;

contract ExampleContract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function restricted to the owner
    function restrictedFunction() public onlyOwner {
        // Restricted code
    }
}
