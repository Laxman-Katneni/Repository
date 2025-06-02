/* File Created by James Fitzgerald on 11/7/2023
Functions used on sin, cos, tan buttons*/


//Global varable for radian/degree for reference
let radOrDeg = "rad";

/**
 * Created by James Fitzgerald on 11/7/2023
 * Performs arithmetic specified by trigOp
 * @param{function} trigOp
 * Edited by James Fitzgerald on 11/7/2023: Compressed 3 functions down to 1 with a function parameter
 * Edited by James Fitzgerald on 11/7/2023: Added if statement and arithmetic for converting radians to degrees
*/
  function trigOperation(trigOp) {
    const display = document.getElementById("calculator-display");
    const currentValue = parseFloat(display.innerText);
    operatedValue = trigOp(currentValue);
    if(radOrDeg==="deg"){
        // Converts Radians to Degree
        operatedValue = (operatedValue/Math.PI)*180;
    }
    display.innerText = operatedValue.toString();
    storeDisplayValue();
  }

/*Created by James Fitzgerald on 11/7/2022 
Changes radian/degree button and radOrDeg value*/
  function radDeg(){
    const button = document.getElementById("button-rad-deg");
    const currentState = button.innerText;
    //Switches state based on currentState
    if (currentState === "rad") {
      button.innerText = "deg";
      radOrDeg="deg";
    } else if (currentState === "deg") {
      button.innerText = "rad";
      radOrDeg="rad";
    }
  }
  
  /*Edited by James Fitzgerald on 11/7/2023: rewritten to include function call with parameter*/
  /*Edited by James Fitzgerald on 11/7/2023: added radDeg button element*/
  document.getElementById("button-rad-deg").addEventListener("click", radDeg);
  document.getElementById("button-sin").addEventListener("click", function () {
    trigOperation(Math.sin);
  });
  document.getElementById("button-cos").addEventListener("click",  function () {
    trigOperation(Math.cos);
  });
  document.getElementById("button-tan").addEventListener("click", function () {
    trigOperation(Math.tan);
  });