pragma solidity ^0.8.0;

contract DAO {
    
    struct Member {
        bool exists;
        uint256 votingPower;
    }
    
    
    mapping(address => Member) public members;
    
    
    uint256 public totalVotingPower;
    
    
    modifier onlyMembers {
        require(members[msg.sender].exists, "Only members can call this function");
        _;
    }
    
  
    event MemberAdded(address indexed member, uint256 votingPower);
    
   
    function addMember(address _member, uint256 _votingPower) external {
        require(!members[_member].exists, "Member already exists");
        members[_member] = Member(true, _votingPower);
        totalVotingPower += _votingPower;
        emit MemberAdded(_member, _votingPower);
    }
    
    
    function removeMember(address _member) external onlyMembers {
        require(members[_member].exists, "Member does not exist");
        totalVotingPower -= members[_member].votingPower;
        delete members[_member];
    }
    
  
    struct Proposal {
        address proposer;
        string description;
        uint256 votes;
        bool executed;
    }
    
    
    Proposal[] public proposals;
    
  
    function createProposal(string memory _description) external onlyMembers {
        proposals.push(Proposal(msg.sender, _description, 0, false));
    }
    
   
    function vote(uint256 _proposalIndex) external onlyMembers {
        require(_proposalIndex < proposals.length, "Invalid proposal index");
        require(!proposals[_proposalIndex].executed, "Proposal already executed");
        require(!hasVoted(_proposalIndex, msg.sender), "Already voted");
        
        proposals[_proposalIndex].votes += members[msg.sender].votingPower;
    }
    
    
    function executeProposal(uint256 _proposalIndex) external {
        require(_proposalIndex < proposals.length, "Invalid proposal index");
        require(!proposals[_proposalIndex].executed, "Proposal already executed");
        
        if (proposals[_proposalIndex].votes * 2 > totalVotingPower) {
           
            proposals[_proposalIndex].executed = true;
           
        }
    }
    
  
    function hasVoted(uint256 _proposalIndex, address _voter) internal view returns (bool) {
        return (proposals[_proposalIndex].votes > 0);
    }
}
