pragma solidity ^0.8.0;

contract SimpleFundraiser {
    address public owner;
    uint public totalRaised;
    bool private initialized;

    function initialize() public {
        require(!initialized, "Already initialized");
        owner = msg.sender;
        totalRaised = 0;
        initialized = true;
    }

    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than 0");
        totalRaised += msg.value;
    }

    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(address(this).balance >= amount, "Insufficient funds");
        payable(owner).transfer(amount);
    }

    function getTotalRaised() public view returns (uint) {
        return totalRaised;
    }
}
