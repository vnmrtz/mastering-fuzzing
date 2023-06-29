# Mastering Fuzzing

This repo contains all the details to follow along with the ["Mastering Fuzzing"](https://www.youtube.com/watch?v=83q14K-WNKM) workshop/talk. 


:star: The target audience includes both **smart contract developers** and **security people** looking to improve their testing practices and dive into the world of fuzzing.


:point_right: If you are already used to working with fuzzing the first part of this content may be a bit too basic for you :smiley:


## Foundry setup

All the fuzzing tests will be done using foundry and echidna. It does not matter if you are not familiar with the tool as the tests and examples are already prepared, so you just have to follow the instructions. However, if you want to learn more about the tool, please check the foundry [official documentation](https://book.getfoundry.sh/)


First and foremost, install Foundry following [these details](https://github.com/foundry-rs/foundry#installation). After the successful installation, please run the following to check that everything is in place:
```sh
foundryup # look for updates
forge init myTestProject # Create a foundry template project
cd myTestProject 
forge test # run the current tests
```

If the above tests were successful, your Foundry instance is ready for the workshop :heavy_check_mark:

Now install echidna following [these details](https://github.com/crytic/echidna#installation).

After the successful installation, you are ready to start the workshop :heavy_check_mark:

## Workshop

First and foremost, clone this repo, and install run the following command to install the dependences:
```sh
forge install 
```

You will find the demo contracts inside the `src/` folder. And the different tests/PoCs inside the `test/` folder.

Echidna tests are located under `echidna` and foundry tests under `test/`. The echidna tests are already prepared to be run with the following command:
```sh
echidna --config echidna.yaml echidna/ERC20Test.sol --contract ERC20Test  
```

# Fuzzing

### Echidna 

Echidna is a property-based fuzzer for Ethereum smart contracts. It is a tool that allows you to write tests in Solidity and then automatically generates inputs that trigger the tests to fail. It is a very powerful tool that can be used to find bugs.

The tests are written in Solidity and are very similar to the ones you may already be familiar with. The main difference is that you have to use the `echidna_*` functions to define the properties you want to test. 

The file [ERC20Test.sol](/echidna/ERC20Test.sol) contains a very simple example of internal testing with echidna. The test is very simple, it checks a few properties of the ERC20 token.

From the root of the repo, run the following command to run the test:
```sh
echidna --config echidna.yaml echidna/ERC20Test.sol --contract ERC20Test  
```

### Prebuilt properties Echidna

Crytic has a set of prebuilt properties that can be used to test your contracts. You can find the list of properties [here](https://github.com/crytic/properties).

The file [ERC20Harness.sol](/echidna/ERC20Harness.sol) contains a very simple example of external testing with echidna. Using this set of prebuilt properties, we can test the ERC20 token.

### Foundry

Foundry is a popular smart contract development framework that allows you to write tests in Sold¡ty. It comes with fuzzing and property-based testing support out of the box. 


Run parametrized tests:
```sh
forge test --mp test/ClonesTest.t.sol
```

Run invariant tests:
```sh
forge test --mt invariant_poolBalanceAlwaysGtThanInitialBalance
```

Test with trace:
```sh
forge test --mt invariant_poolBalanceAlwaysGtThanInitialBalance -vvvv
```


