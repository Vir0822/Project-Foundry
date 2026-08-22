
# Calculator Smart Contract

A Solidity-based smart contract implementing a basic calculator with access control and automated validation using [Foundry](https://book.getfoundry.sh/).

This project demonstrates core blockchain development principles, including state management, event emission, permission checks, and test-driven validation in a smart contract environment.

## Overview

The contract maintains a public state variable named `resultado` and an administrator address named `admin`. It supports basic arithmetic operations including addition, subtraction, multiplication, and division.

Division is restricted to the contract administrator, while the remaining operations are public. This pattern is useful for demonstrating permission-based logic and contract security practices in Solidity.

## Functionalities

The contract implements the following operations:

- `addition`: adds two numbers and stores the result
- `substraction`: subtracts two numbers and stores the result
- `multiplier`: multiplies two numbers and stores the result
- `division`: divides two numbers and stores the result, restricted to `admin`

## Contract details

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

The constructor initializes:

- `resultado = firstResultado_`
- `admin = admin_`

This defines the initial state of the contract and the authorized account allowed to call the division function.

## Access control

The division operation is protected by the following modifier:

```solidity
modifier onlyadmin() {
    require(msg.sender == admin, "Not allowed");
    _;
}
```

Any call to `division` from an unauthorized address triggers a revert with the message `Not allowed`.

## Events

Each operation emits an event containing the input parameters and the resulting value:

- `Addition`
- `Substraction`
- `Multiplier`
- `Division`

These events provide traceability and allow external consumers to track contract activity without reading the full state directly.

## Project objectives

This project is intended to showcase the following engineering concepts:

- Solidity state variables and contract design
- event-driven contract interaction
- access control patterns
- error handling with `require` and reverts
- automated testing with Foundry
- fuzz testing for edge-case validation

## Requirements

To run this project locally, you need:

- [Foundry](https://book.getfoundry.sh/)
- Git
- optionally Node.js for supporting tooling

## Getting started

1. Clone the repository
2. Navigate to the project directory
3. Compile the project:

```bash
forge build
```

4. Run the tests:

```bash
forge test
```

5. Format the Solidity files:

```bash
forge fmt
```

## Test coverage

The project includes automated tests covering:

- constructor initialization
- correct addition behavior
- correct subtraction behavior
- correct multiplication behavior
- multiplication overflow protection
- unauthorized division attempts
- authorized division execution
- division by zero handling
- fuzz testing for random values

## Current status

The contract is fully functional and the test suite passes with Foundry. It serves as a solid foundation for extending the project with more advanced smart contract patterns.

## Current limitations

- Access control is currently applied only to division.
- Other arithmetic functions remain public by design.
- Division relies on Solidity’s native revert behavior for invalid or zero-value paths.

## Repository structure

```text
.
├── src/
│   └── Calculadora.sol
├── test/
│   └── CalculadoraTest.t.sol
├── README.md
├── foundry.toml
├── lib/
└── out/
```

## Useful resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)

## License

MIT
