import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Scanner;
import java.util.Set;

/**
 *
 * Tag Cloud Generator - a Java program that counts word occurrences in a given
 * input file and outputs an HTML document with a tag cloud of the N most common
 * words in alphabetical order.
 *
 * @Lucky Katneni and Trent Jackson
 *
 */

class ValueComparator implements Comparator<Map.Entry<String, Integer>> {
    @Override
    public int compare(Map.Entry<String, Integer> o1,
            Map.Entry<String, Integer> o2) {

        Integer num1 = o1.getValue();
        Integer num2 = o2.getValue();

        Integer diff = num2 - num1;

        if (diff == 0) {
            String str1 = o1.getKey();
            String str2 = o2.getKey();

            diff = str1.compareToIgnoreCase(str2);

        }

        return diff;

    }
}

class KeyComparator implements Comparator<Map.Entry<String, Integer>> {
    @Override
    public int compare(Map.Entry<String, Integer> o1,
            Map.Entry<String, Integer> o2) {
        String str1 = o1.getKey();
        String str2 = o2.getKey();

        return str1.compareToIgnoreCase(str2);

    }

}

public final class TagCloudGenerator {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private TagCloudGenerator() {
    }

    /**
     * Checks whether the given {@code String} represents a valid integer value
     * in the range Integer.MIN_VALUE..Integer.MAX_VALUE.
     *
     * @param s
     *            the {@code String} to be checked
     * @return true if the given {@code String} represents a valid integer,
     *         false otherwise
     * @ensures canParseInt = [the given String represents a valid integer]
     */
    public static boolean canParseInt(String s) {
        assert s != null : "Violation of: s is not null";
        try {
            Integer.parseInt(s);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /*
     * To output the header of the html file with title and the heading
     *
     * @param out - output file
     *
     * @param fileName - input file name
     */
    private static void outputHeader(PrintWriter out, String fileName, int n) {

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Top " + n + " words in " + fileName + "</title>");
        out.println(
                "<link href=\"doc/tagcloud.css\" rel=\"stylesheet\" type=\"text/css\">");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Top " + n + " words in " + fileName + "</h2>");
        out.println("<hr>");
        out.println("<div class = \"cdiv\">");
        out.println("<p class = \"cbox\">");

    }

    /*
     * To output the html code for the table of words in tagcloud,css style
     * arranged alphabetically
     *
     * @param keySorter - Sorted Keys
     *
     * @param min - minimum number of words
     *
     * @param max - maximum number of words
     *
     * @param out - output html file
     */
    private static void outputTable(PrintWriter out,
            List<Map.Entry<String, Integer>> sorter, int min, int max) {

        while (sorter.size() > 0) {
            Map.Entry<String, Integer> wordCount = sorter.remove(0);

            final int maxFontSize = 42;
            final int minFontSize = 12;

            double fontNumber = maxFontSize - minFontSize;
            fontNumber *= (wordCount.getValue() - min);

            fontNumber /= (max - min);
            fontNumber += minFontSize;

            String font = "f" + (int) fontNumber;

            out.println("<span style=\"cursor:default\" class=\"" + font
                    + "\" title=\"count: " + wordCount.getValue() + "\">"
                    + wordCount.getKey() + "</span>");
        }

    }

    /*
     * To output html footer
     */
    private static void outputFooter(PrintWriter out) {

        out.println("</p>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    /*
     * To get sorted words from the lines
     */
    private static void getSortedWords(Queue<String> lines, List<String> words,
            Set<Character> sep) {

        while (lines.size() > 0) {
            String line = lines.remove();
            int st = 0; // position

            while (st < line.length()) {
                int nd = nextSeparator(line, st, sep);

                if (nd != st) { // To consider for situations where the starting itself is

                    String word = line.substring(st, nd);
                    words.add(word);

                }

                st = nd + 1;
            }

        }

        words.sort(String.CASE_INSENSITIVE_ORDER); // To sort them alphabetically
    }

    /*
     * To create a set of all possible separators
     */

    private static void generateSeparators(Set<Character> s) {
        String sep = ",<.> /?'\";:\\|]}[{=+-_)(*&^%$#@!~`1234567890";

        for (int i = 0; i < sep.length(); i++) {
            if (!s.contains(sep.charAt(i))) { // Checking if the separator is already there in the set. (Not required, but just in case to be sure)
                s.add(sep.charAt(i));
            }
        }
    }
    /*
     * To get the location of the next separator
     */

    private static int nextSeparator(String line, int pos, Set<Character> sep) {

        int j = pos;

        while (j < line.length() && !sep.contains(line.charAt(j))) { // To find out the position of the separator

            j++;
        }
        return j;
    }

    /*
     * To map all the sorted words and the count of each of them
     */
    private static void getWordMap(Map<String, Integer> map,
            List<String> words) {

        while (words.size() > 0) {
            String word = words.remove(0);

            Integer value = map.putIfAbsent(word, 1);

            if (value != null) {
                value++;
                map.remove(word);
                map.put(word, value);
            }
        }
    }

    // Reduces the Map to include only the pairs with the N highest values
    // Ensures that the Map remains sorted & generates the table using outputTable

    private static void generateTable(Map<String, Integer> map, int n,
            PrintWriter out) {

        Comparator<Map.Entry<String, Integer>> valueSort = new ValueComparator();
        Comparator<Map.Entry<String, Integer>> keySort = new KeyComparator();

        int maxCount = 0;
        int minCount = 0;

        List<Map.Entry<String, Integer>> sorter = new LinkedList<Map.Entry<String, Integer>>();

        Set<Map.Entry<String, Integer>> words = map.entrySet();
        //put the map into a set
        for (Map.Entry<String, Integer> entry : words) {
            sorter.add(entry);
        }
        /*
         * while (map.size() > 0) {
         *
         * Map.Entry<String, Integer> temp = map.remove(); sorter.add(temp); }
         */
        sorter.sort(valueSort);
        List<Map.Entry<String, Integer>> sorter2 = sorter.subList(0, n);
        sorter2.sort(keySort);

        Map.Entry<String, Integer> temp = sorter2.remove(0);
        maxCount = temp.getValue();

        sorter2.add(0, temp);

        Map.Entry<String, Integer> temp2 = sorter2.remove(sorter2.size() - 1);
        minCount = temp2.getValue();

        sorter2.add(sorter2.size(), temp);

        outputTable(out, sorter2, minCount, maxCount);

    }

    /**
     * Main method.
     *
     * @param args
     *            the command line arguments
     */
    public static void main(String[] args) {

        Scanner in = new Scanner(System.in);

        String outName = "";
        PrintWriter outFile = null;
        System.out.println("Enter name of the output file: "); // Output file

        try {
            outName = in.nextLine();
            outFile = new PrintWriter(
                    new BufferedWriter(new FileWriter(outName)));

        } catch (IOException e) {
            System.err.println("Error: invalid input for outgoing file");
            in.close();
            return;
        }

        System.out.println("Enter name of the input file: "); // Input file

        String inName = "";
        BufferedReader inFile = null;

        try {
            inName = in.nextLine();
            inFile = new BufferedReader(new FileReader(inName));
        } catch (IOException e) {
            System.err.println("Error: invalid input for incoming file");
        }

        System.out.println("Enter number of words included in tag cloud: ");

        boolean can = false;

        String numberOfWordsString = "";
        int numberOfWords = 0;
        try {
            numberOfWordsString = in.nextLine();
            // copy/paste CanParseInt into a separate method

        } catch (RuntimeException e) {
            System.err.println("Error: invalid input for number of words" + e);
        }
        can = canParseInt(numberOfWordsString);

        if (!can) {
            System.err.println("Error: invalid input for number of words ");

        } else {
            numberOfWords = Integer.parseInt(numberOfWordsString);

            Set<Character> separators = new LinkedHashSet<Character>(); // To list all types of separators
            generateSeparators(separators);

            if (inFile != null) {
                Queue<String> lines = new LinkedList<String>();
                String line = null;
                try {
                    line = inFile.readLine();
                } catch (IOException e) {
                    System.err.println("Error reading from input file");
                }
                while (line != null) { // To list all the lines in the input file

                    line = line.toLowerCase();

                    lines.add(line);

                    try {
                        line = inFile.readLine();
                    } catch (IOException e) {
                        System.err.println("Error reading from input file");
                    }
                }

                List<String> words = new LinkedList<String>();
                getSortedWords(lines, words, separators);

                Map<String, Integer> wordMap = new HashMap<>();
                getWordMap(wordMap, words);

                outputHeader(outFile, inName, numberOfWords); // Processing the html file with the data loaded above in maps and queues

                generateTable(wordMap, numberOfWords, outFile);

                outputFooter(outFile);
            }
        }

        // Closing both the files
        try {
            inFile.close();
        } catch (IOException e) {
            System.err.println("Error closing input file");
        }

        outFile.close();

        in.close();
    }

}
