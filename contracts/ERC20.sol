// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

error EmptyAddress(address adr);

contract CERC20 {
    event Transfer(address indexed _from, address indexed _to, uint amount);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    uint immutable _totalSupply;
    uint balanceCount;

    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) _allowance;

    modifier NotEmpty(address who) {
        if(who == address(0x0)) 
            revert EmptyAddress(who);
        _;
    }

    constructor() {
        // 总共2100万枚
        _totalSupply = 21000000 ether;
    }

    receive() external payable {
        require(balanceCount + msg.value < _totalSupply);
        balance[msg.sender] += msg.value;
    }

    // 返回代币的名字
    function name() public pure returns(string memory) {
        return "Chan";
    }
    // 返回代币的符号
    function symbol() public pure returns(string memory) {
        return "CA";
    }
    // 返回代币的小数位数
    function decimals() public pure returns(uint) {
        return 18;
    }

    function totalSupply() public view returns(uint) {
        return _totalSupply;
    }

    // 查看余额
    function balanceOf(address _owner) public NotEmpty(_owner) view returns(uint) {
        return balance[_owner];
    }

    function transferFrom(address from, address to, uint amount) public
        NotEmpty(from)
        NotEmpty(to)
        returns(bool) {
            // 当前拥有多少代币
            uint currentBalance = balance[from];
            require(amount <= currentBalance, "not have enought coin");
            if(from != msg.sender) {
                // 当前有多少批准额度
                uint currentAllowance = allowance(from, msg.sender);
                // 额度不够
                require(amount <= currentAllowance, "not have enought approve");
                // 扣除额度
                _allowance[from][msg.sender] -= amount;
            }
            balance[from] -= amount;
            balance[to] += amount;
            emit Transfer(from, to, amount);
            return true;
        }
        
    // 转账
    function transfer(address to, uint amount) public NotEmpty(to) returns(bool) {
        return transferFrom(msg.sender, to, amount);
    }

    // 批准
    function approve(address spender, uint amount) public NotEmpty(spender) returns(bool) {
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address _owner, address _spender) public NotEmpty(_owner) NotEmpty(_spender) view returns(uint) {
        return _allowance[_owner][_spender];
    }

    function withdraw(uint amount) public returns(bool) {
        require(amount <= balance[msg.sender], "not have enough coin");
        balance[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "failed");
        return success;
    }
}