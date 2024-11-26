pragma solidity >=0.4.22 <0.6.0;

contract Parent {
    uint internal sum;

    function setValue() external {
        uint a = 10;
        uint b = 20;
        sum = a + b;
    }
}

contract Child is Parent {
    function getValue() external view returns (uint) {
        return sum;
    }
}
