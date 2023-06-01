pragma solidity 0.8.13;

import "../../src/ExampleToken.sol";
import {CryticERC20ExternalBasicProperties} from "@crytic/properties/contracts/ERC20/external/properties/ERC20ExternalBasicProperties.sol";


contract ERC20Harness is CryticERC20ExternalBasicProperties {
    constructor() {
        //Deploy ERC20
        //token = new ExampleToken();
    }
}
