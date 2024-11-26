pragma solidity ^0.8.0;

contract Math {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b; // Pure function, no state modification or reading
    }
}