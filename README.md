
# Calculator Smart Contract

A personal project built with Solidity and [Foundry](https://book.getfoundry.sh/) to create a smart contract that emulates a basic calculator on the blockchain.

The main goal is to demonstrate how arithmetic operations, state persistence, access control, and automated testing can be implemented in an Ethereum smart contract.

## Overview

This contract stores a public value called `resultado` and an administrator named `admin`. Based on this state, it can perform basic mathematical operations such as addition, subtraction, multiplication, and division.

The key characteristic is that division is restricted to the `admin`, while the other operations remain public. This makes it a practical example of access control patterns in Solidity.

## What the project does

The contract allows:

- setting an initial result when deployed
- performing arithmetic operations on `uint256` values
- storing the latest result in the public variable `resultado`
- emitting events with the input values and the calculated result
- restricting division so only the authorized account can execute it

## Contract features

| Function | Description | Access |
|---|---|---|
| `addition` | Adds two numbers and returns the result | Public |
| `substraction` | Subtracts two numbers and returns the result | Public |
| `multiplier` | Multiplies two numbers and returns the result | Public |
| `division` | Divides two numbers and returns the result | Admin only |

### Constructor

```solidity
constructor(uint256 firstResultado_, address admin_)
```

This constructor initializes:

- `resultado = firstResultado_`
- `admin = admin_`

So when the contract is deployed, it defines both the starting value and the authorized address allowed to execute division.

## Security rule

The division function uses the following modifier:

```solidity
modifier onlyadmin() {
    require(msg.sender == admin, "Not allowed");
    _;
}
```

This ensures that any call to `division` from an unauthorized address reverts.

## Emitted events

Each operation emits an event with the input values and final result:

- `Addition`
- `Substraction`
- `Multiplier`
- `Division`

This makes it possible to track activity from indexed logs without reading the full contract state every time.

## Project objectives

This project is designed to practice and demonstrate the following Solidity and Foundry concepts:

- state variables and contract storage
- event emission
- access control using `require`
- revert handling and error validation
- unit testing with Foundry
- fuzz testing for more robust behavior checks

## Requirements

To run this project, you need:

- [Foundry](https://book.getfoundry.sh/)
- Git
- optionally Node.js for tooling support

## How to run the project

1. Clone the repository
2. Go to the project folder
3. Compile the contract:

```bash
forge build
```

4. Run the tests:

```bash
forge test
```

5. Format the code:

```bash
forge fmt
```

## Test coverage

The test suite checks:

- constructor value initialization
- correct addition
- correct subtraction
- correct multiplication
- overflow protection in multiplication
- unauthorized access to division
- successful division by admin
- division by zero reversion
- fuzz execution with random values

## Current project status

The contract is functional and the tests pass with Foundry. It is a solid base for future extensions such as:

- additional arithmetic operators
- role-based permissions
- operation history tracking
- more advanced access control rules

## Current limitations

- Access control is only applied to division.
- Other operations are intentionally public.
- The division operation relies on Solidity’s native revert behavior for zero division and unauthorized access.

## Repository structure

```text
.
├── src/
│   └── Calculadora.sol
├── test/
│   └── CalculadoraTest.t.sol
├── README.md
├── foundry.toml
└── lib/
```

## Useful resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)

## License

MIT
