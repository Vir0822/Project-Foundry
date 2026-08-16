# CALCULATOR

A basic calculator Smart Contract, implemented using Solidity and [Foundry](https://book.getfoundry.sh/), with access control on one of its operations and a unit + fuzz testing suite. Personal project, no tutorial or course followed as a base.

## Objectives

Implement an on-chain calculator with the following functionalities:

- `addition`: adds two numbers and emits an event with the result ✅
- `substraction`: subtracts two numbers and emits an event with the result ✅
- `multiplier`: multiplies two numbers and emits an event with the result ✅
- `division`: divides two numbers, restricted to `admin` only ✅

> ⚠️ Note: currently only `division` has access control (`onlyadmin`). The other three operations are public. Confirm whether this is intentional before using in production.

## Contract details

| Function | Signature | Access |
|---|---|---|
| Addition | `addition(uint256, uint256) external returns (uint256)` | Public |
| Substraction | `substraction(uint256, uint256) external returns (uint256)` | Public |
| Multiplier | `multiplier(uint256, uint256) external returns (uint256)` | Public |
| Division | `division(uint256, uint256) external returns (uint256)` | Admin only |

**Constructor:**

```solidity
constructor(uint256 firstResultado_, address admin_)
```

Sets the initial result (`resultado`) and defines the `admin` address, the only one authorized to call `division`.

**Error handling:**

- `division` reverts if `msg.sender != admin` (`"Not allowed"`).
- `division` reverts natively when dividing by zero.
- `multiplier` reverts natively on overflow (built-in arithmetic check in Solidity ^0.8).

## Requirements to build a similar project from scratch

Start a Foundry project:

```bash
forge init project-name
cd project-name
```

Install dependencies:

```bash
forge install foundry-rs/forge-std
```

Add a `.gitignore` file containing:

```
# Foundry files
cache/
out/
broadcast/

# Env
.env

# Dependencies
lib/
```

Compile and run tests:

```bash
forge build
forge test
```

## Test coverage (`CalculadoraTest.t.sol`)

- `testCheckFirstResultado` — verifies the initial result set in the constructor.
- `testAddition` — validates addition.
- `testSubstraction` — validates substraction.
- `testMultiplier` — validates multiplication.
- `testCanNotMultiply2LargeNumbers` — confirms revert on overflow.
- `testIfNotAdminCallsDivisionReverts` — confirms revert when a non-admin calls `division`.
- `testAdminCanCallDivisionCorrectly` — confirms the admin can call `division`.
- `testDefaultCanNotCallDivisionCorrectly` — confirms revert for unauthorized access.
- `testDefaultExecutesCorrectly` — validates the result of `division` executed by the admin.
- `testCanNotDivideByZero` — confirms revert when dividing by zero.
- `testFuzzingDivision(uint256, uint256)` — fuzz test on `division`, executed as admin.

## Known issues

- [ ] Decide whether `addition`, `substraction` and `multiplier` should also have access control, to be consistent with `division`.
- [ ] `testFuzzingDivision` has no assertions — it only checks that the call doesn't revert. Needs to validate the expected result and handle the `secondNumber_ == 0` case (via `vm.assume` or a conditional `expectRevert`).

## Project structure

```
.
├── src/
│   └── Calculadora.sol
├── test/
│   └── CalculadoraTest.t.sol
└── README.md
```

## Resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Docs](https://docs.soliditylang.org/)


## License

MIT
