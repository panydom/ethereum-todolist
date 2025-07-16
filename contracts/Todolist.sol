// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Todolist {
    uint public taskCount = 0;

    struct Task {
        uint id;
        string name;
        bool finished;
    }

    mapping (uint => Task) tasks;
    event TaskCreated(uint id, string name, bool finished);
    event TaskFinished(uint id, bool finished);

    constructor() {
        createTask("Todo List Tourist");
    }

    function createTask(string memory name) public {
        taskCount++;
        Task memory task = Task({id: taskCount, name: name, finished: false});
        tasks[taskCount] = task;

        emit TaskCreated(taskCount, name, false);
    }

    function toggleStatus(uint id) public {
        Task memory task = tasks[id];
        task.finished = !task.finished;
        tasks[id] = task;
        emit TaskFinished(id, task.finished);
    }
}