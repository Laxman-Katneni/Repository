/* Created by Kaushik Jegath on 10/31/23. */

/* Operation functions. */
// Log base 10
function operationLog() {
    let x = document.getElementById("calculator-display").innerText;
    document.getElementById("calculator-display").innerText = Math.log10(x).toString();
}

// Natural log
function operationLn() {
    let x = document.getElementById("calculator-display").innerText;
    document.getElementById("calculator-display").innerText = Math.log(x).toString();
}

// Factorial
function operationFact() {
    let x = document.getElementById("calculator-display").innerText;
    var y = 1;
    for (var i = parseInt(x); i > 0; i--) {
        y *= i;
    }
    document.getElementById("calculator-display").innerText = y.toString();
}

// Sign flip
function operationFlip() {
    let x = document.getElementById("calculator-display").innerText;
    let y = parseInt(x) * -1;
    document.getElementById("calculator-display").innerText = y.toString();
}


/* Button selection. */
var logButton = document.getElementById("button-operation-log");
var lnButton = document.getElementById("button-operation-ln");
var factButton = document.getElementById("button-operation-!");
var flipButton = document.getElementById("button-operation-flip");


/* Event listeners. */
logButton.addEventListener("click", operationLog);
lnButton.addEventListener("click", operationLn);
factButton.addEventListener("click", operationFact);
flipButton.addEventListener("click", operationFlip);
