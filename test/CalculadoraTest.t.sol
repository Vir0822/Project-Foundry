// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import "../src/Calculadora.sol";
import "forge-std/Test.sol";

contract CalculadoraTest is Test {

Calculadora calculadora;
uint256 public firstResultado = 100;
address public admin = vm.addr(1); 
address public randomUser = vm.addr(2); 

function setUp() public {
calculadora = new Calculadora(firstResultado, admin);
} 

// unit testing 
function testCheckFirstResultado() public view {
 uint256 firstResultado_ = calculadora.resultado();
 assert(firstResultado == firstResultado_); 
}

function testAddition() public {
   uint256 firstNumber_ = 5;
   uint256 secondNumber_ = 5;

    uint256 resultado_ = calculadora.addition(firstNumber_, secondNumber_);

    assert(resultado_ == firstNumber_ + secondNumber_);
}

function testSubstraction() public {

uint256 firstNumber_ = 5;
uint256 secondNumber_ = 5;

uint256 resultado_ = calculadora.substraction(firstNumber_, secondNumber_);

assert(resultado_ == firstNumber_ - secondNumber_);
}

function testMultiplier()public {
uint256 firstNumber_ = 5;
uint256 secondNumber_ = 5;

uint256 resultado_ = calculadora.multiplier(firstNumber_, secondNumber_);

assert(resultado_ == firstNumber_ * secondNumber_);
}

function testCanNotMultiply2LargeNumbers() public {

uint256 firstNumber_ = 5;
uint256 secondNumber_ = 115792089237316195423570985008687907853269984665640564039457584007913129639934;


vm.expectRevert();
calculadora.multiplier(firstNumber_, secondNumber_);
}

function testIfNotAdminCallsDivisionReverts()public {
  vm.startPrank(randomUser);

 uint256 firstNumber_ = 5;
 uint256 secondNumber_ = 2;
 vm.expectRevert();
 calculadora.division(firstNumber_, secondNumber_);


  vm.stopPrank();
}

function testAdminCanCallDivisionCorrectly()public {
    vm.startPrank(admin);

 uint256 firstNumber_ = 5;
 uint256 secondNumber_ = 2;
 calculadora.division(firstNumber_, secondNumber_);


  vm.stopPrank();
}

function testDefaultCanNotCallDivisionCorrectly()public {
 uint256 firstNumber_ = 5;
 uint256 secondNumber_ = 2;
 console.log(msg.sender);
 vm.expectRevert();
 calculadora.division(firstNumber_, secondNumber_);
}

function testDefaultExecutesCorrectly() public {
vm.startPrank(admin);

uint256 firstNumber_ = 5;
uint256 secondNumber_ = 2;
uint256 result_ = calculadora.division(firstNumber_, secondNumber_);
assert(result_ == firstNumber_ / secondNumber_);

vm.stopPrank();
}

function testCanNotDivideByZero() public {
vm.startPrank(admin);

uint256 firstNumber_ = 5;
uint256 secondNumber_ = 0;

vm.expectRevert();
calculadora.division(firstNumber_, secondNumber_);

vm.stopPrank();
}

    // fuzzing testing 
function testFuzzingDivision(uint256 firstNumber_, uint256 secondNumber_)public {
vm.startPrank(admin);

calculadora.division(firstNumber_, secondNumber_);

vm.stopPrank();
}



}