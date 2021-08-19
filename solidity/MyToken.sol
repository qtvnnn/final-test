// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract MyToken is ERC20 {
    address public owner;
    constructor() ERC20('Test Token', 'NAT'){
        _mint(msg.sender, 1000000 * 10 ** 18);
        owner = msg.sender;
    }
    
    function mint(address to, uint amount) external {
        require(msg.sender == owner, 'only admin');
        _mint(to, amount);
    }
    
    function isContract(address addr) public view returns(bool){
        uint32 size;
        assembly {
            size := extcodesize(addr)
        }
        return (size > 0);
    }
    
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        require(isContract(spender));
        _approve(_msgSender(), spender, amount);
        return true;
    }
}