// SPDX-License-Identifier: MIT
pragma solidity >=0.8;
//import "hardhat/console.sol";
import "./symbolW3G.sol";

contract governance {

    address payable public owner;
    string public nameProposal;
    string public descriptionProposal;
    uint dateLimitProposal;
    uint idProposal = 0;
    uint positiveVotes;
    uint negativeVotes;
    string state;
    SymbolW3GBasic private token2;

    modifier UnicamenteOwner(address _direccion){
        require(_direccion == owner);
        _;
    }

    modifier UnicamenteTieneW3G(address _direccion){
        require(token2.balanceOf(_direccion)>0);
        _;
    }

    constructor(){
        owner = payable(msg.sender);
    }



    function createProposal(string memory _nameProposal, string memory _descriptionProposal, uint _dateLimitProposal) public UnicamenteOwner(owner) {
        idProposal = idProposal;
        idProposal++;
        nameProposal = _nameProposal;
        descriptionProposal = _descriptionProposal;
        dateLimitProposal = _dateLimitProposal;
        positiveVotes = 0;
        negativeVotes = 0;
        state = "Abierta";
    }

    function changeTheState() public {
        if(dateLimitProposal < block.timestamp){
            state = "Cerrada";
        }
    }

    function viewProposal() public view UnicamenteTieneW3G(msg.sender) returns(uint, string memory, string memory, uint, uint, string memory) {
        return(idProposal, nameProposal, descriptionProposal, positiveVotes, negativeVotes, state);
    }
}