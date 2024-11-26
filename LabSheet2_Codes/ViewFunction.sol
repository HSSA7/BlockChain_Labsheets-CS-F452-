pragma solidity ^0.8.0;

contract ViewExample {
    uint private value;

    // View function: can read the state variable
    function getValue() public view returns (uint) {
        return value; // Returns the current state variable
    }
}
