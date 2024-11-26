// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;

    struct Task {
        uint256 id;
        string description;
        bool completed;
    }

    Task[] private tasks; // Array to store tasks
    uint256 private nextId; // Counter for task IDs

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event TaskAdded(uint256 taskId, string description);
    event TaskCompleted(uint256 taskId);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    // ====== Balance Management ====== //
    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint256 _previousBalance = balance;

        require(msg.sender == owner, "You are not the owner of this account");

        balance += _amount;

        assert(balance == _previousBalance + _amount);

        emit Deposit(_amount);
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint256 _previousBalance = balance;

        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        balance -= _withdrawAmount;

        assert(balance == (_previousBalance - _withdrawAmount));

        emit Withdraw(_withdrawAmount);
    }

    // ====== Task Management ====== //
    function addTask(string memory _description) public {
        require(msg.sender == owner, "Only the owner can add tasks");

        tasks.push(Task(nextId, _description, false));
        emit TaskAdded(nextId, _description);
        nextId++;
    }

    function getTasks() public view returns (Task[] memory) {
        return tasks;
    }

    function markTaskCompleted(uint256 _taskId) public {
        require(msg.sender == owner, "Only the owner can mark tasks as completed");

        for (uint256 i = 0; i < tasks.length; i++) {
            if (tasks[i].id == _taskId) {
                tasks[i].completed = true;
                emit TaskCompleted(_taskId);
                break;
            }
        }
    }
}
