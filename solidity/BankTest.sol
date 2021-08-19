// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract BankTest {
    address owner;
    IERC20 public newToken;
    uint totalTrans;
    struct Transaction
    {
        address addrFrom;
        address addrTo;
        uint amount;
    }
    
    constructor(address addr, address addrOwner) {
        newToken = IERC20(addr);
        owner = addrOwner;
    }

    mapping(uint => Transaction) transList;
    mapping(address => uint[]) storeHistoryTrans; 
    
    event TransactionDone(uint total);
    
    function transferBank(address to, uint amount) public {
        newToken.transferFrom(msg.sender, to, amount);
        
        totalTrans++;
        Transaction storage trans = transList[totalTrans];
        trans.addrFrom = msg.sender;
        trans.addrTo = to;
        trans.amount = amount;
        
        storeHistoryTrans[msg.sender].push(totalTrans);
        
        emit TransactionDone(totalTrans);
    }
    
    function transDetail(uint number) public view returns(Transaction memory trans) {
        return transList[number];
    }
    
    function transByAddress(address addr) public view returns(Transaction[] memory) {
        uint[] memory listTransId = storeHistoryTrans[addr];
        Transaction[] memory listTrans = new Transaction[](listTransId.length);
        for(uint i = 0; i < listTransId.length; i++) {
            listTrans[i] = (transList[listTransId[i]]);
        }
        return listTrans;
    }
}