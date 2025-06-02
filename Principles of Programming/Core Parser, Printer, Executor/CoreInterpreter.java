import java.io.*;
import java.util.*;

public class CoreInterpreter {
    public static void main(String[] args) {
        // Main driver - expects two files: programFile and inputFile
        if (args.length != 2) {
            System.out.println("Usage: java CoreInterpreter <programFile> <inputFile>");
            return;
        }

        try {
            // Tokenize the program and parse it
            Tokenizer tokenizer = new Tokenizer(args[0]);
            Program program = new Program();
            program.parse(tokenizer);

            // Pretty-print the program
            System.out.println("Pretty-Printed Core Program:");
            program.print(0);

            // Execute the parsed program using input data
            Context context = new Context(args[1]);
            System.out.println("\nExecuting Program:");
            program.execute(context);
        } catch (Exception e) {
            // Catch and display any errors
            System.err.println("Error: " + e.getMessage());
        }
    }
}

class Tokenizer {
    private List<String> tokens = new ArrayList<>();
    private int index = 0;

    public Tokenizer(String filename) throws IOException {
        // Reads program file and splits it into tokens
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
        while ((line = reader.readLine()) != null) {
            tokens.addAll(Arrays.asList(line.trim().split("\\s+")));
        }
        reader.close();
    }

    public String getToken() {
        // Returns current token
        return index < tokens.size() ? tokens.get(index) : null;
    }

    public void skipToken() {
        // Moves to the next token
        if (index < tokens.size()) index++;
    }

    public boolean hasMoreTokens() {
        // Checks if there are more tokens
        return index < tokens.size();
    }
}

class Context {
    private Map<String, Integer> variables = new HashMap<>();
    private Queue<Integer> inputs = new LinkedList<>();

    public Context(String inputFile) throws IOException {
        // Reads input file and queues the numbers
        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        String line;
        while ((line = reader.readLine()) != null) {
            inputs.add(Integer.parseInt(line.trim()));
        }
        reader.close();
    }

    public void declare(String name) {
        // Declares a variable
        if (variables.containsKey(name)) throw new RuntimeException("Variable already declared: " + name);
        variables.put(name, null);
    }

    public void assign(String name, int value) {
        // Assigns a value to a variable
        if (!variables.containsKey(name)) throw new RuntimeException("Variable not declared: " + name);
        variables.put(name, value);
    }

    public int get(String name) {
        // Gets the value of a variable
        if (!variables.containsKey(name)) throw new RuntimeException("Variable not declared: " + name);
        if (variables.get(name) == null) throw new RuntimeException("Variable not initialized: " + name);
        return variables.get(name);
    }

    public int readInput() {
        // Reads the next value from input queue
        if (inputs.isEmpty()) throw new RuntimeException("Input data exhausted");
        return inputs.poll();
    }
}

class Program {
    private DeclSeq declSeq;
    private StmtSeq stmtSeq;

    public void parse(Tokenizer tokenizer) throws Exception {
        // Parses declaration and statement sequences
        declSeq = new DeclSeq();
        declSeq.parse(tokenizer);

        if (!"begin".equals(tokenizer.getToken())) throw new Exception("Expected 'begin'");
        tokenizer.skipToken();

        stmtSeq = new StmtSeq();
        stmtSeq.parse(tokenizer);

        if (!"end".equals(tokenizer.getToken())) throw new Exception("Expected 'end'");
        tokenizer.skipToken();
    }

    public void print(int indent) {
        // Pretty-prints declarations and statements
        declSeq.print(indent);
        System.out.println("begin");
        stmtSeq.print(indent + 1);
        System.out.println("end");
    }

    public void execute(Context context) throws Exception {
        // Executes declarations and statements
        declSeq.execute(context);
        stmtSeq.execute(context);
    }
}

class DeclSeq {
    private List<String> declarations = new ArrayList<>();

    public void parse(Tokenizer tokenizer) {
        // Parses declaration sequence
        while ("int".equals(tokenizer.getToken())) {
            tokenizer.skipToken();
            declarations.add(tokenizer.getToken());
            tokenizer.skipToken();
        }
    }

    public void print(int indent) {
        // Pretty-prints each declaration
        for (String decl : declarations) {
            printIndent(indent);
            System.out.println("int " + decl + ";");
        }
    }

    public void execute(Context context) {
        // Executes variable declarations
        for (String decl : declarations) context.declare(decl);
    }

    private void printIndent(int indent) {
        // Adds proper indentation
        System.out.print("    ".repeat(indent));
    }
}

class StmtSeq {
    private List<Statement> statements = new ArrayList<>();

    public void parse(Tokenizer tokenizer) throws Exception {
        // Parses statement sequence
        while (!"end".equals(tokenizer.getToken())) {
            Statement stmt = new Statement();
            stmt.parse(tokenizer);
            statements.add(stmt);
        }
    }

    public void print(int indent) {
        // Pretty-prints each statement
        for (Statement stmt : statements) stmt.print(indent);
    }

    public void execute(Context context) throws Exception {
        // Executes each statement
        for (Statement stmt : statements) stmt.execute(context);
    }
}

class Statement {
    private String varName;
    private String type;

    public void parse(Tokenizer tokenizer) throws Exception {
        // Parses "read" or "write" statements
        type = tokenizer.getToken();
        tokenizer.skipToken();

        if ("read".equals(type) || "write".equals(type)) {
            varName = tokenizer.getToken();
            tokenizer.skipToken();
        } else {
            throw new Exception("Invalid statement type");
        }
    }

    public void print(int indent) {
        // Pretty-prints the statement
        printIndent(indent);
        System.out.println(type + " " + varName + ";");
    }

    public void execute(Context context) throws Exception {
        // Executes "read" or "write" statements
        if ("read".equals(type)) {
            context.assign(varName, context.readInput());
        } else if ("write".equals(type)) {
            System.out.println(varName + " = " + context.get(varName));
        }
    }

    private void printIndent(int indent) {
        // Adds proper indentation
        System.out.print("    ".repeat(indent));
    }
}
