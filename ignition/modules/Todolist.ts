import {buildModule} from '@nomicfoundation/hardhat-ignition/modules';

export default buildModule("TodoListModule", m => {
    const todoList = m.contract("Todolist", []);
    return {todoList}
})