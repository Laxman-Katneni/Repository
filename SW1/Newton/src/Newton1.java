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
public final class Newton1 {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private Newton1() {
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
     */
    private static double sqrt(double x) {
        double r = x; // Guess for square root of x

        while (Math.abs(r * r - x) / x > 0.000001) {
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

            double squareRoot = sqrt(x);

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
