pragma solidity >=0.4.22 <0.6.0;

contract A {
    string internal name = "Contract A";

    function setName() external {
        name = "Updated A";
    }
}

contract B {
    uint internal value;

    function setValue() external {
        value = 100;
    }
}

contract C is A, B {
    function getDetails() external view returns (string memory, uint) {
        return (name, value);
    }
}
