/* Created by Kaushik Jegath on 11/7/23. */
let mem = 0;

function memClear() {
    mem = 0;
}

function memRecall() {
    document.getElementById("calculator-display").innerText = mem.toString();
}

function memAdd() {
    mem += parseFloat(document.getElementById("calculator-display").innerText);
}

function memSubtract() {
    mem -= parseFloat(document.getElementById("calculator-display").innerText);
}

function memStore() {
    mem = parseFloat(document.getElementById("calculator-display").innerText);
}

/* Select memory buttons. */
var memClearButton = document.getElementById("button-memory-clear");
var memRecallButton = document.getElementById("button-memory-recall");
var memAddButton = document.getElementById("button-memory-add");
var memSubtractButton = document.getElementById("button-memory-subtract");
var memStoreButton = document.getElementById("button-memory-store");

/* Add event listeners to buttons. */
memClearButton.addEventListener("click", memClear);
memRecallButton.addEventListener("click", memRecall);
memAddButton.addEventListener("click", memAdd);
memSubtractButton.addEventListener("click", memSubtract);
memStoreButton.addEventListener("click", memStore);
