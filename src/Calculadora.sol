// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Calculadora {
    // Variables
    uint256 public resultado;
    address public admin;

    // Events
    event Addition(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Substraction(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Multiplier(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);
    event Division(uint256 firstNumber_, uint256 secondNumber_, uint256 resultado_);

    // Modifiers
    modifier onlyadmin() {
        require(msg.sender == admin, "Not allowed");
        _;
    }

    constructor(uint256 firstResultado_, address admin_) {
        resultado = firstResultado_;
        admin = admin_;
    }

    // Functions

    // 1. Addition
    function addition(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 resultado_) {
        resultado_ = firstNumber_ + secondNumber_;
        resultado = resultado_;

        emit Addition(firstNumber_, secondNumber_, resultado_);
    }

    // 2. Substraction
    function substraction(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 resultado_) {
        resultado_ = firstNumber_ - secondNumber_;
        resultado = resultado_;

        emit Substraction(firstNumber_, secondNumber_, resultado_);
    }

    // 3. Multiplier
    function multiplier(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 resultado_) {
        resultado_ = firstNumber_ * secondNumber_;
        resultado = resultado_;

        emit Multiplier(firstNumber_, secondNumber_, resultado_);
    }

    // 4. Division
    function division(uint256 firstNumber_, uint256 secondNumber_) external onlyadmin returns (uint256 resultado_) {
        resultado_ = firstNumber_ / secondNumber_;
        resultado = resultado_;
        emit Division(firstNumber_, secondNumber_, resultado_);
    }
}
