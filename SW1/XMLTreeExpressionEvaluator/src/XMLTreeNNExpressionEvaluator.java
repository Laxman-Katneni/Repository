import components.naturalnumber.NaturalNumber;
import components.naturalnumber.NaturalNumber2;
import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;
import components.utilities.Reporter;
import components.xmltree.XMLTree;
import components.xmltree.XMLTree1;

/**
 * Program to evaluate XMLTree expressions of {@code NN}.
 *
 * @author Lucky Katneni
 *
 */
public final class XMLTreeNNExpressionEvaluator {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private XMLTreeNNExpressionEvaluator() {
    }

    /**
     * Evaluate the given expression.
     *
     * @param exp
     *            the {@code XMLTree} representing the expression
     * @return the value of the expression
     * @requires <pre>
     * [exp is a subtree of a well-formed XML arithmetic expression]  and
     *  [the label of the root of exp is not "expression"]
     * </pre>
     * @ensures evaluate = [the value of the expression]
     */
    private static NaturalNumber evaluate(XMLTree exp) {
        assert exp != null : "Violation of: exp is not null";

        // TODO - fill in body

        /*
         * This line added just to make the program compilable. Should be
         * replaced with appropriate return statement.
         */

        //Assuming the input is correct

        if (exp.label().equals("plus")) {
            NaturalNumber num1 = new NaturalNumber2(evaluate(exp.child(1)));
            NaturalNumber num0 = new NaturalNumber2(evaluate(exp.child(0)));
            num0.multiply(num1);
            return num0;
        } else if (exp.label().equals("divide")) {
            NaturalNumber num1 = new NaturalNumber2(evaluate(exp.child(1)));
            NaturalNumber num0 = new NaturalNumber2(evaluate(exp.child(0)));
            if (num1.isZero()) {
                Reporter.fatalErrorToConsole("Dividing by zero error!");
            }
            num0.divide(num1);
            return num0;
        } else if (exp.label().equals("times")) {
            NaturalNumber num1 = new NaturalNumber2(evaluate(exp.child(1)));
            NaturalNumber num0 = new NaturalNumber2(evaluate(exp.child(0)));
            num0.multiply(num1);

            return num0;
        } else if (exp.label().equals("minus")) {
            NaturalNumber num1 = new NaturalNumber2(evaluate(exp.child(1)));
            NaturalNumber num0 = new NaturalNumber2(evaluate(exp.child(0)));
            num0.subtract(num1);
            return num0;
        } else if (exp.label().equals("number")) {
            return new NaturalNumber2(
                    Integer.parseInt(exp.attributeValue("value")));
        }
        return new NaturalNumber2(0);

    }

    /**
     * Main method.
     *
     * @param args
     *            the command line arguments
     */
    public static void main(String[] args) {
        SimpleReader in = new SimpleReader1L();
        SimpleWriter out = new SimpleWriter1L();

        out.print("Enter the name of an expression XML file: ");
        String file = in.nextLine();
        while (!file.equals("")) {
            XMLTree exp = new XMLTree1(file);
            out.println(evaluate(exp.child(0)));
            out.print("Enter the name of an expression XML file: ");
            file = in.nextLine();
        }

        in.close();
        out.close();
    }

}