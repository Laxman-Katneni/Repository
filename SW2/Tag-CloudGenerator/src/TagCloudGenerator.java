
import java.util.Comparator;

import components.map.Map;
import components.map.Map1L;
import components.queue.Queue;
import components.queue.Queue1L;
import components.set.Set;
import components.set.Set1L;
import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;
import components.sortingmachine.SortingMachine;
import components.sortingmachine.SortingMachine1L;
import components.utilities.FormatChecker;
import components.utilities.Reporter;

/**
 *
 * Tag Cloud Generator - a Java program that counts word occurrences in a given
 * input file and outputs an HTML document with a tag cloud of the N most common
 * words in alphabetical order.
 *
 * @Laxman Katneni and Trent Jackson
 *
 */

class ValueComparator implements Comparator<Map.Pair<String, Integer>> {
    @Override
    public int compare(Map.Pair<String, Integer> o1,
            Map.Pair<String, Integer> o2) {

        Integer num1 = o1.value();
        Integer num2 = o2.value();

        return num2.compareTo(num1);

    }
}

class KeyComparator implements Comparator<Map.Pair<String, Integer>> {
    @Override
    public int compare(Map.Pair<String, Integer> o1,
            Map.Pair<String, Integer> o2) {
        String str1 = o1.key();
        String str2 = o2.key();

        if (str1.compareToIgnoreCase(str2) > 0) {
            return 1;
        } else if (str1.compareToIgnoreCase(str2) < 0) {
            return -1;
        } else {
            return 0;
        }
    }
}

public final class TagCloudGenerator {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private TagCloudGenerator() {
    }

    /*
     * To output the header of the html file with title and the heading
     *
     * @param out - output file
     *
     * @param fileName - input file name
     */
    private static void outputHeader(SimpleWriter out, String fileName, int n) {

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
    private static void outputTable(SimpleWriter out,
            SortingMachine<Map.Pair<String, Integer>> keySorter, int min,
            int max) {

        while (keySorter.size() > 0) {
            Map.Pair<String, Integer> wordCount = keySorter.removeFirst();

            final int maxFontSize = 42;
            final int minFontSize = 12;

            double fontNumber = maxFontSize - minFontSize;
            fontNumber *= (wordCount.value() - min);
            fontNumber /= (max - min);
            fontNumber += minFontSize;

            String font = "f" + (int) fontNumber;

            out.println("<span style=\"cursor:default\" class=\"" + font
                    + "\" title=\"count: " + wordCount.value() + "\">"
                    + wordCount.key() + "</span>");
        }

    }

    /*
     * To output html footer
     */
    private static void outputFooter(SimpleWriter out) {

        out.println("</p>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html");
    }

    /*
     * To get sorted words from the lines
     */
    private static void getSortedWords(Queue<String> lines, Queue<String> words,
            Set<Character> sep) {

        while (lines.length() > 0) {
            String line = lines.dequeue();
            int st = 0; // position

            while (st < line.length()) {
                int nd = nextSeparator(line, st, sep);

                if (nd != st) { // To consider for situations where the starting itself is

                    String word = line.substring(st, nd);
                    words.enqueue(word);

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
            Queue<String> words) {
        Queue<String> temp = words.newInstance();

        temp.transferFrom(words);

        while (temp.length() > 0) {
            String word = temp.dequeue();

            if (!map.hasKey(word)) { // To check if the word already exists in the map and also to remove the duplicates from the queue of words
                map.add(word, 1);
                words.enqueue(word);

            } else {
                int i = map.value(word); // To increment if the word already exists
                i++;

                map.replaceValue(word, i);
            }
        }
    }

    // Reduces the Map to include only the pairs with the N highest values
    // Ensures that the Map remains sorted & generates the table using outputTable

    private static void generateTable(Map<String, Integer> map, int n,
            SimpleWriter out) {

        Comparator<Map.Pair<String, Integer>> valueSort = new ValueComparator();
        Comparator<Map.Pair<String, Integer>> keySort = new KeyComparator();

        SortingMachine<Map.Pair<String, Integer>> valueSorter = new SortingMachine1L<>(
                valueSort);
        SortingMachine<Map.Pair<String, Integer>> keySorter = new SortingMachine1L<>(
                keySort);

        int maxCount = 0;
        int minCount = 0;

        while (map.size() > 0) {
            Map.Pair<String, Integer> tempPair = map.removeAny();
            valueSorter.add(tempPair);
        }

        valueSorter.changeToExtractionMode();

        if (valueSorter.size() > 0) {
            Map.Pair<String, Integer> tempPair = valueSorter.removeFirst();
            maxCount = tempPair.value();
            keySorter.add(tempPair);
        }
        for (int i = 2; valueSorter.size() > 1 && i < n; i++) {
            Map.Pair<String, Integer> tempPair = valueSorter.removeFirst();
            keySorter.add(tempPair);
        }

        if (valueSorter.size() > 0) {
            Map.Pair<String, Integer> tempPair = valueSorter.removeFirst();
            minCount = tempPair.value();
            keySorter.add(tempPair);
        }

        keySorter.changeToExtractionMode();

        outputTable(out, keySorter, minCount, maxCount);

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

        out.println("Enter name of the input file: "); // Input file

        String inName = in.nextLine();
        SimpleReader inFile = new SimpleReader1L(inName);

        out.println("Enter name of the output file: "); // Output file
        SimpleWriter outFile = new SimpleWriter1L(in.nextLine());

        out.println("Enter number of words included in tag cloud: "); // Number of words in tag cloud
        String numberOfWordsString = in.nextLine();

        Reporter.assertElseFatalError(
                FormatChecker.canParseInt(numberOfWordsString),
                "Error: invalid input");

        int numberOfWords = Integer.parseInt(numberOfWordsString);

        Set<Character> separators = new Set1L<>(); // To list all types of separators
        generateSeparators(separators);

        Queue<String> lines = new Queue1L<String>();
        while (!inFile.atEOS()) { // To list all the lines in the input file
            lines.enqueue(inFile.nextLine());
        }

        Queue<String> words = new Queue1L<String>();
        getSortedWords(lines, words, separators);

        Map<String, Integer> wordMap = new Map1L<>();
        getWordMap(wordMap, words);

        outputHeader(outFile, inName, numberOfWords); // Processing the html file with the data loaded above in maps and queues

        generateTable(wordMap, numberOfWords, outFile);

        outputFooter(outFile);

        inFile.close(); // Closing both the files
        outFile.close();

        /*
         * Close input and output streams
         */
        in.close();
        out.close();
    }

}
