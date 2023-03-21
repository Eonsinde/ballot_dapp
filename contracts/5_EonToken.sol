// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EonToken {
    string public constant name = "Udacity Token";
    string public constant symbol = "UDC";
    uint8 public constant decimals = 18; // 18 is the most common number of decimal places
    uint _totalSupply;

    // balances for each account stored using a mapping
    mapping(address => uint256) balances;

    // the key represent the address to whom allocations are made 
    // the value represent a mapping of accounts that approved allowances to the key address 
    mapping(address => mapping(address => uint256)) allowances;

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    // set the total supply of the tokens i.e the number of available tokens for circulation
    // also give the inital total supply to the address that instantiates the contract
    constructor(uint amount) {
        _totalSupply = amount;
        balances[msg.sender] = amount;
    }

    // return the total supply of tokens i.e total number of available tokens
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // get the balance for an address i.e the amount of tokens an address has
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    // transfer a certain amount of tokens from the root address(one that instantiates the contract) to another 
    function transfer(address to, uint tokens) public returns (bool success) {
        // deduct the number of tokens to the sent from the caller's address balance
        balances[msg.sender] = balances[msg.sender] - tokens;

        // increase the balance of the intended recipient address
        balances[to] = balances[to] + tokens;
        emit Transfer(msg.sender, to, tokens);

        success = true;
    }

    // transfer a certain amount of tokens using another address(e.g a contract address)
    // to another address; the from param stands as an intermediary between root address and the to address
    // allow the from address to send tokens on behalf of the msg.sender
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = balances[from] - tokens;
        allowances[from][msg.sender] = allowances[from][msg.sender] - tokens;
        
        // increase the token balance of the intended recipient address
        balances[to] = balances[to] + tokens;

        // emit transfer event
        emit Transfer(from, to, tokens);
        
        success = true;
    }

    // approves the spender to withdraw from your account as many times as the specified tokens
    function approve(address spender, uint tokens) public returns (bool success) {
        allowances[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        success = true;
    }

    // allocates
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        remaining = 10;
    }
}