// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {

    // State variables
    mapping(address => uint256) public balances;
    address public owner;
    uint256 public depositFee = 0.01 ether;  // Default Fee in ETH

    // Events
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event FeeUpdated(uint256 newFee);

    // Constructor to set the owner (when contract is deployed)
    constructor() {
        owner = msg.sender;  // The deployer becomes the owner
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Deposit function: Allows a user to deposit funds (payable)
    function deposit() public payable {
        // Ensure that the deposit is greater than the fee
        require(msg.value > depositFee, "Deposit must be greater than the fee");
        
        // Deduct the deposit fee and add the remaining balance to the user's balance
        uint256 depositAmountInWei = msg.value - depositFee;
        balances[msg.sender] += depositAmountInWei;

        // Emit the event for deposit with the amount in ETH
        emit Deposited(msg.sender, depositAmountInWei / 1 ether); // Convert back to ETH for readability
    }

    // Withdraw function: Allows a user to withdraw funds
    function withdraw(uint256 _amountInEth) public {
        // Convert the requested amount from ETH to wei
        uint256 amountInWei = _amountInEth * 1 ether;

        // Ensure the user has enough balance to withdraw
        require(balances[msg.sender] >= amountInWei, "Insufficient balance");

        // Deduct the amount from the user's balance
        balances[msg.sender] -= amountInWei;

        // Transfer the amount to the user
        payable(msg.sender).transfer(amountInWei);

        // Emit the event for withdrawal with the amount in ETH
        emit Withdrawn(msg.sender, _amountInEth); // Emit in ETH for readability
    }

    // Only owner can update the deposit fee
    function updateDepositFee(uint256 _newFeeInWei) public onlyOwner {
        // Ensure that the new fee is a valid amount
        require(_newFeeInWei > 0, "Fee must be greater than 0");

        // Update the deposit fee directly with the new fee in wei
        depositFee = _newFeeInWei;

        // Emit the event for fee update with the new fee in wei
        emit FeeUpdated(_newFeeInWei);  // Emit in wei for better accuracy
    }

    // Get the current deposit fee in Wei (view function)
    function getDepositFeeInWei() public view returns (uint256) {
        return depositFee; // Return fee in wei
    }

    // Get the balance of the sender in Wei (view function)
  function getBalanceInEth() public view returns (uint256, uint256) {
    uint256 wholeEth = balances[msg.sender] / 1 ether; // Integer part
    uint256 fractionalWei = balances[msg.sender] % 1 ether; // Fractional part
    return (wholeEth, fractionalWei);
}

}
