Author: Lucky Katneni
Email: katneni.3@buckeyemail.osu.edu

List of Files Submitted:
CoreInterpreter.java: This is the main source file that implements the Core interpreter. It parses a Core program, pretty-prints it, and then executes it using an input file.
program.txt: This is a sample Core program file containing declarations and statements that follow the specified grammar.
input.txt: This is the sample input file with integers used during the execution of the program.
Documentation.txt: This file provides an overview of the interpreter's design, testing methods, and any limitations or known issues.
README.txt: The current file. It contains a list of submitted files, descriptions, and instructions on how to compile and run the program.
Description:
I implemented this project in Java
Instructions to Compile and Run:
Open a terminal and run:
javac CoreInterpreter.java
Run the program:
Execute the interpreter with a program file and input file:
java CoreInterpreter program.txt input.txt
Replace program.txt and input.txt with the paths to your own files if desired.
Notes:
The program validates the Core syntax as per the given grammar. Errors like undeclared variables, multiple declarations, or uninitialized variables during execution will cause the program to terminate with a detailed error message.
Acknowledgment:
I used ChatGPT during the implementation process as a learning aid, particularly when debugging issues or clarifying conceptual doubts. This helped me better understand the requirements and refine my approach to achieve the desired output.

Testing and Known Issues:
Testing: I tested the interpreter extensively using various Core programs, including edge cases like empty input files or invalid variable usage.
Known Issues: The program currently assumes well-formatted input files and does not handle malformed tokens or files not adhering to the Core syntax.
