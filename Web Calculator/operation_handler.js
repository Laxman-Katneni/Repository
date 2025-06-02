/* 11/1/2023 Created by Liam */
/* File edited by Ethan 11/6/2023: continued operation functionality*/

let displayValue = 0;
let storedValue = 0;
/* Mode is an indicator of which math operation (+, -, *, /) the user has most recently pressed.*/
let mode = "";
let operationClicked = false;

// Store the display element as variable since we access it all the time.
let displayElement = document.getElementById("calculator-display");

/**
 * Created 11/1/2023 by Liam
 * Edited by Kaushik on 11/7/23
 * Stores the value in the display into local variable.
 * 
 * Created 11/1.2023 by Liam
 */
/*Edited by James Fitzgerald on 11/7/2023 Changed parseInt to parseFloat */
function storeDisplayValue() {
    displayValue = displayElement.innerText;
    storedValue = parseFloat(displayValue);
}

/**
 * Stores and displays a new value (from a calculation).
 * 
 * Liam created 11/7
 * 
 * @param {number} newValue The new value to go to the display and be stored.
 */
function updateDisplayValue(newValue) {
    displayValue = newValue;
    displayElement.innerText = displayValue.toString();
}

/**
 * Handles calculates the values depending on which mode the calculator is in. Updates storedValue and displayValue with
 * the calculated value.
 * 
 * Created 11/6/2023 by Ethan Chung
 * 11/7/2023 Liam edited: Added multiplication and division cases. Changed if else chain to switch statement. Moved repeated
 *     code outside switch.
 * 11/7/2023 Edited by James Fitzgerald on  Changed parseInt to parseFloat
 * 11/7/2023 Edited by Lucky Katneni - Added power and modulus cases, changed parseInt to parseFloat
 * @param mode The current math operation mode. Must be set to one of '+', '-', 'multiply', or 'divide'.
 */
function calculateValue() {
    //TODO: Start using displayValue variable instead of reading display element.
    value = parseFloat(displayElement.innerText);
    switch (mode) {
        case "+":
            result = math_add(storedValue, value)
            break;
        case "-":
            result = math_subtract(storedValue, value)
            break;
        case "multiply":
            result = math_multiply(storedValue, value);
            break;
        case "divide":
            result = math_divide(storedValue, value);
            break;
        case "power":
            let base = storedValue;
            let exponent = value;
            console.log(`Base: ${base}, Exponent: ${exponent}`);
            result = operationPower(base, exponent);
            console.log(`Power result: ${result}`);
            break;
        case "modulus":
            result = operationModulus(storedValue, value);
            break;
        default:
            console.warn("operation_handler.js function calculateValue was called with mode set incorrectly. Mode was \""
                + mode + "\". Expected '+', '-', 'multiply', or 'divide'");
            return;
    }
    displayElement.innerText = result;
    updateDisplayValue(result);
    storeDisplayValue();
}


/**
 * Handles the basic operations for add, subtract, multiply, divide, and equals
 * 
 * Created 11/6/2023 by Ethan Chung
 * Liam Edited 11/7: Changed if-else chain to switch statement. Added multiplication and division cases.
 * 11/7/2023 Edited by Lucky Katneni - Added power and modulus cases
 * @param {*} event The operation button click event variable
 */
function handleMathOperationClick(event) {
    let operation = event.target.id
    switch (operation) {
        // addition event
        case "button-operation-add": 
            mode = "+";
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        // subtraction event
        case "button-operation-subtract":
            mode = "-";
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        case "button-operation-multiply":
            mode = "multiply";
            console.log(operationClicked);
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        case "button-operation-divide":
            mode = "divide";
            console.log(operationClicked);
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        case "button-operation-power":
            mode = "power";
            console.log(operationClicked);
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        case "button-operation-modulus":
            mode = "modulus";
            console.log(operationClicked);
            if (operationClicked) {
                calculateValue(mode);
            } else {
                operationClicked = true;
                storeDisplayValue();
            }
            break;
        // equals event
        case "button-operation-equals":
            calculateValue(mode);
            storedValue = "";
            operationClicked = false;
            mode = "";
            break;
        default:
            console.warn("operation_handler.js function handleMathOperationClick: operation " + operation
                + " did not match any cases.");
            break;
    }
}

/**
 * Takes the reciprocal of the display value. Does nothing if display value is 0.
 * @param {*} event The reciprocal button click event
 */
function reciprocal(event) {
    value = parseFloat(displayElement.innerText);
    result = 1 / value;
    displayElement.innerText = result.toString();
    storeDisplayValue();
}

/**
 * Create event listeners for +, -, *, /, and = buttons.
 */
function addOperationButtonListeners() {
    /* Button selection */
    let addButtonEl = document.getElementById("button-operation-add");
    let subtractButtonEl = document.getElementById("button-operation-subtract");
    let multiplyButtonEl = document.getElementById("button-operation-multiply");
    let divideButtonEl = document.getElementById("button-operation-divide");
    let powerButtonEl = document.getElementById("button-operation-power");
    let modulusButtonEl = document.getElementById("button-operation-modulus");
    let equalsButtonEl = document.getElementById("button-operation-equals");
    /* Event Listeners */
    addButtonEl.addEventListener("click", handleMathOperationClick);
    subtractButtonEl.addEventListener("click", handleMathOperationClick);
    multiplyButtonEl.addEventListener("click", handleMathOperationClick);
    divideButtonEl.addEventListener("click", handleMathOperationClick);
    powerButtonEl.addEventListener("click", handleMathOperationClick);
    modulusButtonEl.addEventListener("click", handleMathOperationClick);
    equalsButtonEl.addEventListener("click", handleMathOperationClick);
}
// Call immediately
addOperationButtonListeners();