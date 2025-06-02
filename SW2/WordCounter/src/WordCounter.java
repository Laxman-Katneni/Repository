
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

/**
 *
 * Word Counter - a Java program that counts word occurrences in a given input
 * file and outputs an HTML document with a table of the words and counts listed
 * in alphabetical order.
 *
 * @Lucky Katneni
 *
 */
public final class WordCounter {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private WordCounter() {
    }

    /*
     * To output the header of the html file with title and the heading
     *
     * @param out - output file
     *
     * @param fileName - input file name
     */
    private static void outputHeader(SimpleWriter out, String fileName) {

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Words Counted in " + fileName + "</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Words Counted in " + fileName + "</h2>");
        out.println("<hr/>");

    }

    /*
     * To output the html code for the table of words and their counts arranged
     * alphabetically
     *
     * @param map - pairs of words and their counts
     *
     * @param out - output html file
     */
    private static void outputTable(Map<String, Integer> map, SimpleWriter out,
            Queue<String> words) {
        out.println("<table border = '1'>");

        out.println("<tr>");
        out.println("<th>Words</th>");
        out.println("<th>Counts</th>");
        out.println("</tr>");

        while (words.length() > 0) { // To iterate through every word in the queue
            String word = words.dequeue();

            out.println("<tr>");

            out.println("<td>" + word + "</td>");
            out.println("<td>" + map.value(word) + "</td>");

            out.println("</tr>");

        }

    }

    /*
     * To output html footer
     */
    private static void outputFooter(SimpleWriter out) {
        out.println("</table>");
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
            if (!s.contains(sep.charAt(i))) { // Checking if the separator is already there in the set. (Not required, nut just in case to be sure)
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

        outputHeader(outFile, inName); // Processing the html file with the data loaded above in maps and queues
        outputTable(wordMap, outFile, words);
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
