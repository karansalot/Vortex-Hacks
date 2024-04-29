Contract deployed and verified at Scroll Sepolia
https://sepolia.scrollscan.com/address/0xc170317250c31e4acd6eba3f689ebc665c0663a3
constructor(): This is the constructor function that runs only once when the contract is deployed. It sets the admin variable to the address of the account deploying the contract.
addMember(address _member) external onlyAdmin: This function allows the contract administrator to add new members to the DAO. It takes the address of the member to be added as an argument and sets their status to true in the members mapping.
createProposal(string memory _description) external: Members of the DAO can use this function to create new proposals. They provide a description of the proposal as input, which gets stored in the proposals mapping along with other relevant information such as the creator's address, vote counts, and execution status.
vote(uint _id, bool _vote) external: Members can use this function to cast their vote on a specific proposal identified by its ID. They provide the ID of the proposal and a boolean indicating whether they vote in favor (true) or against (false) the proposal. Their vote is recorded in the proposals mapping under the respective proposal ID.
executeProposal(uint _id) external onlyAdmin: This function allows the contract administrator to execute a proposal after it has been approved by the majority of members. It checks whether the proposal has enough votes in favor and has not been executed already, and if so, it executes the proposal's action.
deposit() external payable: Members can deposit funds into the DAO by calling this function and sending Ether along with the transaction. The deposited Ether gets added to the sender's balance in the balances mapping.
withdraw(uint _amount) external: Members can withdraw funds from their balance in the DAO by calling this function and specifying the amount they want to withdraw. The function checks if the sender has sufficient balance and then transfers the specified amount of Ether to the sender's address.
Additionally, the contract includes some modifiers:

onlyAdmin: This modifier restricts access to functions that should only be called by the contract administrator. It checks whether the caller is the administrator before allowing the function to proceed.
The contract also emits events for certain actions:

ProposalCreated: This event is emitted when a new proposal is created, providing information about the proposal ID, creator's address, and description.
Voted: This event is emitted when a member casts their vote on a proposal, providing information about the proposal ID, voter's address, and their vote.
ProposalExecuted: This event is emitted when a proposal is successfully executed by the contract administrator, providing information about the executed proposal's ID.
