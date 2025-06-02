// Created 11/02/2023 by Lucky Katneni
// Calculates power, modulus and Sqaureroots
/**
 * Raise base to the power of exponent.
 * @param {number} base
 * @param {number} exponent
 * @returns base ^ exponent
*/
function operationPower(base, exponent) {
    console.log("operationPower clicked")
    return Math.pow(base, exponent);
}

/**
 * Take the square root of a number.
 * @param {number} value
 * @returns sqrt(value)
 */
function operationSqrt(value) {
    console.log("operationSqrt clicked")
    return Math.sqrt(parseFloat(value));
}
/**
 * 
 * @param {number} dividend 
 * @param {number} divisor 
 * @returns dividend mod divisor
 */
function operationModulus (dividend, divisor){
    return dividend % divisor;
}

// Button selection
var sqrtButton = document.getElementById("button-operation-squareroot");

// Event listeners
sqrtButton.addEventListener("click", function() {
    console.log("sqrt button clicked");
    let x = parseFloat(document.getElementById("calculator-display").innerText);
    let result = operationSqrt(x);
    updateDisplayValue(result);
});
