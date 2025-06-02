// 11/1 Liam Created file: Added add and subtract functions and event listeners.
// 11/6 Ethan Edited file: refactored to add the rest of the operations
// 11/7 Liam Edited file: Renamed parameters from x, y to formal math names

/**
 * Add augend to addend.
 * @param {number} augend 
 * @param {number} addend 
 * @returns {number} sum = augend + addend
 */
function math_add(augend, addend) {
    console.log("Calculating " + augend.toString() + " + " + addend.toString());
    return augend + addend;
}

/**
 * Subtract subtrahend from minuend.
 * @param {number} minuend 
 * @param {number} subtrahend 
 * @returns {number} difference = minuend - subtrahend
*/
function math_subtract(minuend, subtrahend) {
    console.log("Calculating " + minuend.toString() + " - " + subtrahend.toString());
    return minuend - subtrahend;
}

/**
 * Multiply multiplicand and multiplier.
 * @param {number} multiplicand 
 * @param {number} multiplier 
 * @returns {number} product = multiplicand * multiplier 
 */
function math_multiply(multiplicand, multiplier) {
    console.log("Calculating " + multiplicand + " * " + multiplier);
    return multiplicand * multiplier;
}

/**
 * Divide dividend by divisor.
 * @param {number} dividend
 * @param {number} divisor
 * @returns {number} quotient = dividend / divisor
 */
function math_divide(dividend, divisor) {
    console.log("Calculating " + dividend + " / " + divisor);
    return dividend / divisor;
}

