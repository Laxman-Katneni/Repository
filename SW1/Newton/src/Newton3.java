import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;

/**
 * Put a short phrase describing the program here.
 *
 * @author Lucky Katneni
 *
 */
public final class Newton3 {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private Newton3() {
    }

    /**
     * Put a short phrase describing the static method myMethod here.
     */
    /**
     * Computes estimate of square root of x to within relative error 0.01%.
     *
     * @param x
     *            positive number to compute square root of
     * @return estimate of square root
     * @param epsilon
     *            the value entered by the user for the comparision of two
     *            doubles
     */
    private static double sqrt(double x, double epsilon) {

        if (x < 0.000000000000000000001) { // To avoid division by zero in the loop condition
            return x;
        }

        double r = x; // Guess for square root of x

        while (Math.abs(r * r - x) / x > epsilon * epsilon) {
            r = (r + x / r) / 2.0;
        }

        return r;
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

        String pass = "y";

        while (pass.equals("y")) {
            double x = -1;

            while (x < 0) {
                out.println("Enter a positive number: ");
                x = in.nextDouble();
            }

            out.println("Enter the value of epsilon: "); // Taking the value of epsilon from user
            double epsilon = in.nextDouble();

            double squareRoot = sqrt(x, epsilon);

            out.println("The square root of " + x + " is " + squareRoot);

            out.println("Enter 'y' to continue: ");
            pass = in.nextLine();
        }
        /*
         * Close input and output streams
         */

        in.close();
        out.close();
    }

}
