// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract VotingSystem {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        bool isActive;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;

    event ProposalCreated(uint256 proposalId, string description);
    event VoteCast(address indexed voter, uint256 proposalId);
    event VotingConcluded(uint256 proposalId, uint256 voteCount);

    /// @notice Create a new proposal.
    /// @param _description Description of the proposal.
    function createProposal(string memory _description) public virtual payable {
        Proposal storage newProposal = proposals[proposalCount];
        newProposal.id = proposalCount;
        newProposal.description = _description;
        newProposal.isActive = true;

        emit ProposalCreated(proposalCount, _description);
        proposalCount++;
    }

    /// @notice Vote on an active proposal.
    /// @param _proposalId ID of the proposal to vote on.
    function vote(uint256 _proposalId) public virtual {
        Proposal storage proposal = proposals[_proposalId];
        require(proposal.isActive, "Voting has concluded on this proposal.");
        require(!proposal.voters[msg.sender], "You have already voted.");

        proposal.voters[msg.sender] = true;
        proposal.voteCount++;

        emit VoteCast(msg.sender, _proposalId);
    }

    function getProposal(uint256 _proposalId)
        public
        view
        returns (
            uint256 id,
            string memory description,
            uint256 voteCount,
            bool isActive
        )
    {
        Proposal storage proposal = proposals[_proposalId];
        return (
            proposal.id,
            proposal.description,
            proposal.voteCount,
            proposal.isActive
        );
    }

    /// @notice Conclude voting on a proposal.
    /// @param _proposalId ID of the proposal to conclude.
    function concludeVoting(uint256 _proposalId) public virtual {
        Proposal storage proposal = proposals[_proposalId];
        require(proposal.isActive, "Voting already concluded.");
        proposal.isActive = false;

        emit VotingConcluded(_proposalId, proposal.voteCount);
    }
}

// Derived contract with advanced features and access control
contract AdvancedVotingSystem is VotingSystem {
    address public admin;
    uint256 public proposalFee;
    uint256 public totalFeesCollected;

    event FeesWithdrawn(address indexed admin, uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    /// @notice Constructor sets the admin and proposal fee.
    /// @param _proposalFee Fee required to create a proposal.
    constructor(uint256 _proposalFee) {
        admin = msg.sender;
        proposalFee = _proposalFee;
    }

    /// @notice Create a new proposal with a fee.
    /// @param _description Description of the proposal.
    function createProposal(string memory _description)
        public
        payable
        override
    {
        require(msg.value >= proposalFee, "Insufficient proposal fee.");
        totalFeesCollected += msg.value;
        super.createProposal(_description);
    }

    /// @notice Conclude voting on a proposal (admin only).
    /// @param _proposalId ID of the proposal to conclude.
    function concludeVoting(uint256 _proposalId) public override onlyAdmin {
        super.concludeVoting(_proposalId);
    }

    /// @notice Withdraw collected fees (admin only).
    function withdrawFees() public onlyAdmin {
        uint256 amount = totalFeesCollected;
        totalFeesCollected = 0;
        (bool success, ) = payable(admin).call{value: amount}("");
        require(success, "Withdrawal failed.");

        emit FeesWithdrawn(admin, amount);
    }

    /// @notice Change the proposal fee (admin only).
    /// @param _newFee New fee amount.
    function setProposalFee(uint256 _newFee) public onlyAdmin {
        proposalFee = _newFee;
    }
}
