// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/ExampleToken.sol";
import "./util/Constants.sol";

contract ERC20Test is ExampleToken, Constants {

    constructor()  {
        _mint(USER1, INITIAL_BALANCE);
        _mint(USER2, INITIAL_BALANCE);
        _mint(USER3, INITIAL_BALANCE);
    }

    // User balance must never exceed total supply
    function echidna_userBalanceNotHigherThanSupply() public returns (bool) {
        return totalSupply() >= balanceOf(msg.sender);
    }

    // User balances must never exceed total supply
    function echidna_userBalancesNotHigherThanSupply() public returns (bool) {
        uint256 balance = balanceOf(USER1) + balanceOf(USER2) + balanceOf(USER3);
        return totalSupply() >= balance;
    }

    // Zero address does never have balance
    function echidna_zeroAddressDoesNotHaveBalance() public returns (bool) {
        return balanceOf(address(0)) == 0;
    }

    // User cannot transfer more than balance
    function test_transferMoreThanBalance(address target) public returns (bool) {
        uint256 balanceSender = balanceOf(msg.sender);
        uint256 balanceReceiver = balanceOf(target);
        uint256 currentAllowance = allowance(msg.sender, address(this));

        require(balanceSender > 0 && currentAllowance > balanceSender);

        bool success = transferFrom(msg.sender, target, balanceSender + 1);

        assert(!success);  
        assert(balanceSender == balanceOf(msg.sender));
        assert(balanceReceiver == balanceOf(target));
    }
}


// INTERNAL TESTING

//ASSERT 

//tx -> check -> tx -> check


//echidna --config echidna.yaml echidna/ERC20Test.sol --contract ERC20Test   