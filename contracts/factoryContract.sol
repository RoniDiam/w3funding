// SPDX-License-Identifier: MIT
pragma solidity >=0.8;
import "./symbolW3F.sol";
//import "hardhat/console.sol";
import "./symbolW3G.sol";

contract factoryContract {
    // Factory information storage
    mapping(address => address) public myContract;
    mapping(address => uint256) balances;

    function Factory(
        string memory _name,
        string memory _description,
        uint256 _raiseAmount,
        uint256 _priceTokenW3G
    ) public {
        address addressNewContract = address(
            new templateContract(_name, _description, _raiseAmount, _priceTokenW3G)
        );
        myContract[msg.sender] = addressNewContract;
    }
}

contract templateContract {

    SymbolW3FBasic private token;
    SymbolW3GBasic private token2;
    address payable public owner;
    string public name;
    string public description;
    uint256 raiseAmount;
    uint256 priceTokenW3G;
    address public _contract;

    event swapedTokens(uint, address);
    event purchasedTokens(uint, address);


    constructor(string memory _name, string memory _description, uint256 _raiseAmount, uint256 _priceTokenW3G) 
    {
        name = _name;
        description = _description;
        _contract = address(this);
        raiseAmount = _raiseAmount;
        priceTokenW3G = _priceTokenW3G; 
        owner = payable(msg.sender);
        token = new SymbolW3FBasic(10000);
        token2 = new SymbolW3GBasic(10000);
    }

    struct project {
        string name;
        string description;
        uint256 raiseAmount;
    }

    function getTargetAmount() public view returns (uint256) {
        return raiseAmount;
    }

    function tokenPrice(uint _amountOfTokens) internal pure returns(uint) {
        return _amountOfTokens*(1 ether);
    }

    function tokenPriceW3G(uint _amountOfTokens) internal view returns(uint) {
        return _amountOfTokens*priceTokenW3G;
    }

    function generateTokens(uint _amountOfTokens) public Project(msg.sender) {
        token.increaseTotalSupply(_amountOfTokens);
    }

    modifier Project(address _address) {
        require(_address==owner, "You don't have the permissions to execute this function");
        _;
    }

    function buyTokens(uint _amountOfTokens) public payable {
        uint cost = tokenPrice(_amountOfTokens);
        require(msg.value>=cost, "You do not have the amount of ethers necessary for the purchase.");
        uint returnValue = msg.value-cost;
        payable(msg.sender).transfer(returnValue);
        uint balance = balanceOf(); //Me fijo la disponibilidad de tokens
        require(_amountOfTokens<=balance, "The number of tokens requested exceeds the number of tokens for sale.");
        token.transfer(msg.sender, _amountOfTokens); //Se le retorna al cliente
        emit purchasedTokens(_amountOfTokens, msg.sender);
    }

    function balanceOf() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function myTokens() public view returns(uint) {
        return token.balanceOf(msg.sender);
    }

    function swapTokens(uint _amountOfTokens) public payable {
        require(_amountOfTokens>0,"You must return a positive amount of tokens");
        require(_amountOfTokens<=myTokens(), "You can only return what you have");
        token.transferencia_tokens(msg.sender, address(this), _amountOfTokens);
        payable(msg.sender).transfer(tokenPrice(_amountOfTokens));
        emit swapedTokens(_amountOfTokens, msg.sender);
    }
    function contributeTokensToProject(uint256 _amountOfTokens) public{
        token.transferencia_tokens(msg.sender, owner, _amountOfTokens);
    }

    // Esta función no funciona porque siempre me retorna el valor del buy tokens. VER!!
    function totalRaised() public view returns(uint256) {
        return token.balanceOf(address(owner));
    }

    function goalComplete() public view returns(bool) {
        return getTargetAmount() >= totalRaised();
    }

    function buyTokensW3G(uint _amountOfTokensW3F) public payable {
        uint cost = tokenPriceW3G(_amountOfTokensW3F);
        uint totalW3G = msg.value+cost;
        require(totalW3G<=1, "You can not buy more. The maximum is 1 W3G");
        require(msg.value>=cost, "You do not have the amount of ethers necessary for the purchase.");
        uint returnValue = msg.value-cost;
        payable(msg.sender).transfer(returnValue);
        uint balance = balanceOf(); //I check the availability of tokens
        require(_amountOfTokensW3F<=balance, "The number of tokens requested exceeds the number of tokens for sale.");
        token2.transfer(msg.sender, _amountOfTokensW3F); //it is returned to the client
        emit purchasedTokens(_amountOfTokensW3F, msg.sender);
    }
}
