pragma solidity ^0.8.13;

contract SimpleContract {
    uint256 private immutable _number;

    constructor(uint256 number) {
        _number = number;
    }

    function getNumber() external view returns (uint256) {
        return _number;
    }
}