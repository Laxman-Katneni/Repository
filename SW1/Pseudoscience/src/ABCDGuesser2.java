import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;
import components.utilities.FormatChecker;

/**
 * Pseudoscience
 *
 * @author Lucky Katneni
 *
 */
public final class ABCDGuesser2 {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private ABCDGuesser2() {
    }

    /**
     * Repeatedly asks the user for a positive real number not equal to 1.0
     * until the user enters one. Returns the positive real number.
     *
     * @param in
     *            the input stream
     * @param out
     *            the output stream
     * @return a positive real number not equal to 1.0 entered by the user
     */
    private static double getPositiveDoubleNotOne(SimpleReader in,
            SimpleWriter out) {
        double x = -1;
        String constant = "";

        while (!FormatChecker.canParseDouble(constant)
                || Math.abs(x - 1.0) < 0.001 * 0.001) {

            out.println("Enter a positve real number greater than 1");
            constant = in.nextLine();

            if (FormatChecker.canParseDouble(constant)) {

                x = Double.parseDouble(constant);

                if (x - 1.0 < 0.0000001) {
                    out.println(
                            "Real number equal to 1 is not valid.\nTry again");
                }
            } else {
                out.println("Characters are not valid.\nTry again");
            }
        }

        return x;
    }

    /**
     * Repeatedly asks the user for a positive real number until the user enters
     * one. Returns the positive real number.
     *
     * @param in
     *            the input stream
     * @param out
     *            the output stream
     * @return a positive real number entered by the user
     */
    private static double getPositiveDouble(SimpleReader in, SimpleWriter out) {
        double x = -1;
        String constant = "";

        while (!FormatChecker.canParseDouble(constant) || x < 0) {
            out.println("Enter only positve real number");
            constant = in.nextLine();
            if (FormatChecker.canParseDouble(constant)) {
                x = Double.parseDouble(constant);

                if (x < 0) {
                    out.println(
                            "Negative real numbers are not valid.\nTry again");
                }
            } else {
                out.println("Characters are not valid.\nTry again");
            }
        }

        return x;
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

        double constant;
        double[] wxyz = new double[4];
        double[] abc = { -5, -4, -3, -2, -1, -1 / 2, -1 / 3, -1 / 4, 0, 1 / 4,
                1 / 3, 1 / 4, 1, 2, 3, 4, 5 };
        /*
         * Put your main program code here; it may call myMethod as shown
         */
        constant = getPositiveDouble(in, out);

        int i = 0;

        while (i < 4) {
            wxyz[i] = getPositiveDoubleNotOne(in, out);
            i++;
        }

        double a = 0, b = 0, c = 0, d = 0;
        double presentEstimation;
        double accurateEstimation = 0;

        for (int j = 0; j < abc.length; j++) // for w
        {
            double w = Math.pow(wxyz[0], abc[j]);

            for (int k = 0; k < abc.length; k++) // for x
            {
                double x = Math.pow(wxyz[1], abc[k]);

                for (int l = 0; l < abc.length; l++) // for y
                {
                    double y = Math.pow(wxyz[2], abc[l]);

                    for (int m = 0; m < abc.length; m++) {
                        double z = Math.pow(wxyz[3], abc[m]);

                        presentEstimation = w * x * y * z;

                        if (Math.abs(presentEstimation - constant) < Math
                                .abs(accurateEstimation - constant)) {
                            accurateEstimation = presentEstimation;

                            a = abc[j];
                            b = abc[k];
                            c = abc[l];
                            d = abc[m];
                        }

                    }

                }
            }

        }

        out.println("The estimation for " + constant
                + " using Jager's formula is " + accurateEstimation);
        out.println("The powers of the constants entered are " + a + " " + b
                + " " + c + " " + d + " ");

        /*
         * Close input and output streams
         */
        in.close();
        out.close();
    }

}
