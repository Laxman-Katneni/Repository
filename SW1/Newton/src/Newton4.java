import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;

/**
 * Put a short phrase describing the program here.
 *
 * @author Laxman Katneni
 *
 */
public final class Newton4 {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private Newton4() {
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

        double squareRoot = 1;

        int count = 0;

        while (true) // Infinite loop to indirectly indicate the user that its time to quit when he sees a negative value
        {
            double x = -1;

            while (x < 0) {
                out.println("Enter a positive number: ");
                x = in.nextDouble();
            }

            out.println("Enter the value of epsilon: "); // Taking the value of epsilon from user
            double epsilon = in.nextDouble();

            squareRoot = sqrt(x, epsilon);

            if (count > 0) {
                squareRoot = -squareRoot;
            }

            out.println("The square root of " + x + " is " + squareRoot);

            count++;

        }

    }

}
