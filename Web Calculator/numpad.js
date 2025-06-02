/* 11/1/2023 Created by James Fitzgerald on 11/1/2023 functions used for displaying info from numpad */
/**
 * 11/1/2023 Liam edited file. Updated getElementById parameters to reflect updated button IDs.
 * Changed updateAnswer to reflect change calculator display HTML structure
 */ 
/**
 * 11/2/2023 Edited by Lucky Katneni (Added power functionality and seperated Ethan's eval using an if statement)
 * (Added displaying of ^, % to the calculator display)
 */
/**
 * 11/7 Liam Edited: fixed bug with update answer that caused display to show zero infront of every number. Added
 * documentation to global operationClicked1.
 */ 

/**
 * operationClicked will be true whenever the user as pressed an operation button and is entering a new number as the
 * second operator input. For example, user presses 9, then +.
 */
let operationClicked1 = false;

/**
 * Updates the value of the display. Based on operationClicked1, will either (false) append to or (true) replace the
 * value. Updates 
 * 
 * Created 11/1/2023 by James
 * Edited 11/6/2023 by Ethan Chung: Clears display if operation was pressed right before
 * 11/7 Liam Edited: Fixed bug with update answer that caused display to show zero infront of every number. Added
 * documentation to function.
 * 
 * @param {*} value Either a string of a single digit 0-9 or "operation"
 */
function updateAnswer(value) {
  if (value === "operation") {
    operationClicked1 = true;
  }
  if (value !== "operation") {
    if (operationClicked1) {
      clearDisplay();
      operationClicked1 = false;
    } 
    displayEl = document.getElementById("calculator-display")
    if (displayEl.innerText === "0") {
      displayEl.innerText = value;
    } else {
      displayEl.innerText += value;
    }
  }
}

// Created 11/01/2023 by Ethan Chung
// Corresponds with the CE button and removes text from the display
function clearDisplay() {
  document.getElementById("calculator-display").innerText = "0";
}

// Created 11/01/2023 by Ethan Chung
// Corresponds with the C button and all the imformation
function clearCache() {
  storedValue = null;
  displayValue = "";
  mode = "";
  operationClicked = false;
  console.clear();
  document.getElementById("calculator-display").innerText = "0";
}

// Created 11/02/2023 by Lucky Katneni
// Removes the last character from the display
function backspace() {
  let display = document.getElementById("calculator-display").innerText;
  if (display.length > 1) {
      // If the display is more than one character, remove the last character
      document.getElementById("calculator-display").innerText = display.slice(0, -1);
  } else {
      // If the display is only one character, set it to 0
      document.getElementById("calculator-display").innerText = "0";
  }
}

/*
// Created 11/01/2023 by Ethan Chung
// Edited 11/02/2023 by Lucky Katneni (added power functionality and seperated Ethan's eval using an if statement)
function evaluateExpression() {
  
  // Get the expression from the calculator display
  let expression = document.getElementById("calculator-display").innerText;
  console.log(expression);

  // If the expression contains a power operation, use the operationPower function
  if (expression.includes("^")) {
    let operands = expression.split("^");
    
    // Ensure both operands are present and valid
    if (operands.length !== 2 || isNaN(operands[0]) || isNaN(operands[1])) {
      alert("Invalid power operation. Please provide both base and exponent and nothing else");
      return;
    }
    
    let base = parseFloat(operands[0]);
    let exponent = parseFloat(operands[1]);
    
    // Use the operationPower function from power_modulus.js
    let result = operationPower(base, exponent);
    
    document.getElementById("calculator-display").innerText = result;
  }
}
*/
/* Created 11/01/2023 by James Fitzgerald
  Handles functionality for number buttons*/
window.onload=function() {
    //Checks all instances of class Button and ensures function update
    const numButtons = document.querySelectorAll(".button");
    numButtons.forEach((button) => {
      button.addEventListener("click", () => {
        updateAnswer(button.value);
      });
    });

    document.getElementById("button-operation-clear-entry").addEventListener("click", function () {
      clearDisplay();
    });

    document.getElementById("button-operation-clear").addEventListener("click", function () {
      clearCache();
    });


    document.getElementById("button-operation-backspace").addEventListener("click", function() {
      backspace();
    });

    document.getElementById("button-operation-reciprocal").addEventListener("click", reciprocal);

}