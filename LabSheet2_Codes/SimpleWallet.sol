pragma solidity ^0.8.0;

contract SimpleWallet {
    address public owner;
    uint public totalBalance;
    bool private initialized;

    function initialize() public {
        require(!initialized, "Already initialized");
        owner = msg.sender;
        totalBalance = 0;
        initialized = true;
    }

    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than 0");
        totalBalance += amount;
    }

    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalBalance >= amount, "Insufficient balance");
        totalBalance -= amount;
    }

    function getBalance() public view returns (uint) {
        return totalBalance;
    }
}
