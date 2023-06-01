pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "@openzeppelin/contracts/proxy/Clones.sol";

import "../src/SimpleContract.sol";

contract ClonesTest is Test {

    // UNIT TESTS
    function test_predictDeterministicAddress() external {
        address deployer = address(0xddd);
        bytes32 salt = keccak256(abi.encodePacked("the salt"));
        uint256 number = 77;

        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }

    // FUZZ DEPLOYER
    function test_fuzz_predictDeterministicAddressDeployer(address deployer) external {
        bytes32 salt = keccak256(abi.encodePacked("the salt"));
        uint256 number = 77;

        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }    
    
    // FUZZ SALT
    function test_fuzz_predictDeterministicAddressSalt(address deployer, bytes32 salt) external {
        uint256 number = 77;

        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }

    // FUZZ NUMBER
    function test_fuzz_predictDeterministicAddressParameters(address deployer, bytes32 salt, uint256 number) external {
        vm.startPrank(deployer);

        SimpleContract implementation = new SimpleContract(number);

        address cloneAddress = Clones.cloneDeterministic(address(implementation), salt);
        assertEq(implementation.getNumber(), number);
        assertEq(SimpleContract(cloneAddress).getNumber(), number);

        address predictedAddress = Clones.predictDeterministicAddress(address(implementation), salt, deployer);

        assertEq(predictedAddress, cloneAddress);
    }
}

// forge test --mp test/ClonesTest.t.sol