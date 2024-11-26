pragma solidity >=0.4.22 <0.6.0;

contract A {
    string internal x = "Shared Functionality";

    function setX() external {
        x = "Updated Value";
    }
}

contract B is A {
    function getX() external view returns (string memory) {
        return x;
    }
}

contract C is A {
    function getUpdatedX() external view returns (string memory) {
        return x;
    }
}
