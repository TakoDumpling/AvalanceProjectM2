## Assessment and TaskManager Contracts
This project demonstrates the Solidity contract: Assessment for managing account balances and for managing simple task lists. The contract is deployed and can be interacted with through a React.js frontend. This showcases basic Ethereum smart contract functionalities.

## Description
The project includes a contract which has two components:

Assessment: A component for managing deposits, withdrawals, and balances. It ensures secure and valid operations while maintaining consistent states.
TaskManager: A component for managing tasks with functionality to add, mark as completed, and retrieve tasks.

## Features
Assessment Component
Deposit Function: Allows the owner to deposit funds into the account while validating ownership.
Withdraw Function: Allows the owner to withdraw funds, ensuring sufficient balance.
Balance Retrieval: Provides a view of the current account balance.
Custom Errors: Uses require, revert, and assert for error handling and state validation.
TaskManager Component
Add Task: Adds a new task to the task list.
Complete Task: Marks a task as completed based on its index.
Retrieve Tasks: Fetches all tasks along with their completion statuses.

## Code Overview
### Assessment Contract
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }
}
```
### Frontend Interaction
The contracts are connected to a React.js frontend for user interaction. The index.js file provides separate pages for the Assessment and TaskManager components. Users can interact with them via MetaMask.

### Executing Program
Compile Contract: Use Hardhat to compile the Assessment and TaskManager.

Deploy Contract: Run the deploy.js script to deploy the contract to the desired network.

Run Frontend: Use the provided React.js application to connect to the contract via MetaMask and interact with their functions.

### Authors
Shawn Aaron Quirante
