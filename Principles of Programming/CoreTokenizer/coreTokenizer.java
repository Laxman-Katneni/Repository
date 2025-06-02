import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class coreTokenizer {
    // Constants for each token type
    private static final int EOF = 33;
    private static final int ERROR = 34;
    private static final int RESERVED_START = 1;
    private static final int RESERVED_END = 11;
    private static final int SPECIAL_SYMBOL_START = 12;
    private static final int SPECIAL_SYMBOL_END = 30;
    private static final int INTEGER = 31;
    private static final int IDENTIFIER = 32;

    // List of reserved words and special symbols
    private static final String[] RESERVED_WORDS = {
            "program", "begin", "end", "int", "if", "then", "else", "while", "loop", "read", "write"
    };
    private static final String[] SPECIAL_SYMBOLS = {
            ";", ",", "=", "!", "[", "]", "&&", "||", "(", ")", "+", "-", "*", "!=", "==", "<", ">", "<=", ">="
    };

    private BufferedReader reader;
    private List<Token> tokens;
    private int currentTokenIndex;

    // Constructor to initialize the tokenizer with a file
    public coreTokenizer(String fileName) throws IOException {
        reader = new BufferedReader(new FileReader(fileName));
        tokens = new ArrayList<>();
        currentTokenIndex = 0;
        tokenizeFile();
    }

    // Reading through the file and tokenizing it line by line
    private void tokenizeFile() throws IOException {
        for (String line = reader.readLine(); line != null; line = reader.readLine()) {
            tokenizeLine(line);
        }
        // Adding EOF token at the end of the file
        tokens.add(new Token(EOF, "EOF"));
        reader.close();
    }

    // Tokenize a single line of input
    private void tokenizeLine(String line) {
        StringBuilder currentToken = new StringBuilder();
        // System.out.println("Tokenizing line: " + line); Debugging code
        int i = 0;
        while (i < line.length()) {
            char c = line.charAt(i);

            // System.out.println("Tokenizing character: " + c); Debugging code

            // Skipping the whitespaces
            if (Character.isWhitespace(c)) {
                // System.out.println("Encountered whitespace, adding currentToken if not empty."); Debugging code
                addTokenIfNotEmpty(currentToken);
                i++;
                continue;
            }

            // Handling the special symbols
            if (isSpecialSymbolStart(c)) {
                // System.out.println("Special symbol start identified for: " + c); Debugging code
                addTokenIfNotEmpty(currentToken);

                int symbolLength = getSpecialSymbolLength(line, i);
                String symbol = line.substring(i, i + symbolLength);

                // System.out.println("Adding special symbol: " + symbol); Debugging code
                tokens.add(new Token(SPECIAL_SYMBOL_START + getSpecialSymbolIndex(symbol), symbol));
                i = i + symbolLength;

                continue;
            }

            // Handling the reserved words or identifiers
            if (Character.isLetter(c)) {
                
                currentToken.append(c);

                while (i + 1 < line.length() && (Character.isLetter(line.charAt(i + 1)) || Character.isDigit(line.charAt(i + 1)))) {
                    currentToken.append(line.charAt(++i));
                }

                String tokenStr = currentToken.toString();

                if (getReservedWordIndex(tokenStr) != -1) {
                    // System.out.println("Adding reserved word: " + tokenStr); Debugging code
                    addToken(tokenStr);
                } 
                else {
                    // System.out.println("Adding identifier: " + tokenStr); Debugging code
                    tokens.add(new Token(IDENTIFIER, tokenStr));
                }
                currentToken.setLength(0);
                i++;
                continue;
            }

            // Handling the digits for integers
            if (Character.isDigit(c)) {
                currentToken.append(c);
                while (i + 1 < line.length() && Character.isDigit(line.charAt(i + 1))) {
                    currentToken.append(line.charAt(++i));
                }
                // System.out.println("Adding integer: " + currentToken.toString()); Debugging code
                tokens.add(new Token(INTEGER, currentToken.toString()));
                currentToken.setLength(0);
                i++;
                continue;
            }

            

            // System.out.println("Error: Unrecognized character " + c); Debugging code
            
            // To handle the errors for unrecognized characters
            tokens.add(new Token(ERROR, String.valueOf(c)));
            i++;
        }

        addTokenIfNotEmpty(currentToken);
    }

    // To add a token if the currentToken is not empty
    private void addTokenIfNotEmpty(StringBuilder currentToken) {
        if (currentToken.length() > 0) {
            addToken(currentToken.toString());
            currentToken.setLength(0);
        }
    }

    // Add a token based on whether it's a reserved word or an identifier
    private void addToken(String tokenStr) {
        // System.out.println("addToken() called with: " + tokenStr); Debugging code
        int tokenType;
        int index = getReservedWordIndex(tokenStr);
        if (index != -1) {
            tokenType = RESERVED_START + index;
        }       
        else {
            tokenType = IDENTIFIER;
        }

        // System.out.println("Adding token: " + tokenStr + " as type " + tokenType); Debugging code
        tokens.add(new Token(tokenType, tokenStr));
    }

    // Returns the index of the reserved word, or -1 if not found
    private int getReservedWordIndex(String word) {
        int i = 0;
        while (i < RESERVED_WORDS.length) {
            if (RESERVED_WORDS[i].equals(word)) {
                return i;
            }
            i++;
        }
        return -1;
    }

    // Returns the index of the special symbol, or -1 if not found
    private int getSpecialSymbolIndex(String symbol) {
        int i = 0;
        while (i < SPECIAL_SYMBOLS.length) {
            if (SPECIAL_SYMBOLS[i].equals(symbol)) {
                return i;
            }
            i++;
        }
        return -1;
    }

    // Checks if the character could be the start of a special symbol
    private boolean isSpecialSymbolStart(char c) {
        for (String symbol : SPECIAL_SYMBOLS) {
            if (symbol.startsWith(String.valueOf(c))) {
                return true;
            }
        }
        return false;
    }

    // Returns the length of the special symbol in the line starting from index
    private int getSpecialSymbolLength(String line, int index) {
        for (String symbol : SPECIAL_SYMBOLS) {
            if (line.startsWith(symbol, index)) {
                return symbol.length();
            }
        }
        return 1;
    }

    // Returns the current token type
    public int getToken() {
        return tokens.get(currentTokenIndex).getType();
    }

    // Skips to the next token
    public void skipToken() {
        for (; currentTokenIndex < tokens.size() - 1; currentTokenIndex++) {
            break;
        }
        currentTokenIndex++;
    }

    // Returns the integer value of the current token, if it's an integer
    public int intVal() {
        if (getToken() == INTEGER) {
            return Integer.parseInt(tokens.get(currentTokenIndex).getValue());
        }
        throw new IllegalStateException("Current token is not an integer.");
    }

    // Returns the identifier name of the current token, if it's an identifier
    public String idName() {
        if (getToken() == IDENTIFIER) {
            return tokens.get(currentTokenIndex).getValue();
        }
        throw new IllegalStateException("Current token is not an identifier.");
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java coreTokenizer <inputfile>");
            return;
        }
        try {
            coreTokenizer tokenizer = new coreTokenizer(args[0]);
            for (int tokenType = tokenizer.getToken(); tokenType != EOF; tokenType = tokenizer.getToken()) {
                System.out.println(tokenType);
                tokenizer.skipToken();
            }

            // Print the EOF token type after the loop ends
            System.out.println(tokenizer.getToken()); // This will print 33 (EOF)

            System.out.println("End of file reached.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

// A simple class to represent a token with a type and value
class Token {
    private int type;
    private String value;

    public Token(int type, String value) {
        this.type = type;
        this.value = value;
    }

    public int getType() {
        return type;
    }

    public String getValue() {
        return value;
    }
}
