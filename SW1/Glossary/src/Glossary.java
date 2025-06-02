import java.util.Comparator;

import components.map.Map;
import components.map.Map1L;
import components.queue.Queue;
import components.queue.Queue1L;
import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;

/**
 * 
 *
 * @author Laxman Katneni
 *
 */
public final class Glossary {

    /**
     * Private constructor so this utility class cannot be instantiated.
     */
    private Glossary() {
    }

    private static class StringLT implements Comparator<String> { // To compare two strings in a queue
        @Override
        public int compare(String o1, String o2) {
            return o1.compareTo(o2);
        }
    }

    /**
     * Put a short phrase describing the static method myMethod here.
     */
    private static void getGlossaryMap(Map<String, String> GlossaryMap,
            SimpleReader in, Queue<String> words) { // To get a map of words(keys) and meanings(values) for glossary
        /*
         * Put your code for myMethod here
         */
        assert GlossaryMap != null : "Violation of: GlossaryMap is not null";
        assert words != null : "Violation of: words is not null";
        assert in != null : "Violation of: in is not null";
        assert in.isOpen() : "Violation of: in.is_open";

        String word = in.nextLine();
        words.enqueue(word); // Adding the word to the queue

        String meaning = in.nextLine();
        String fullMeaning = meaning; // Intializing full meaning with the present one

        while (!meaning.equals("")) { // Loop to check for additional lines for in meaning

            meaning = in.nextLine();
            fullMeaning += "\n" + meaning;
        }

        GlossaryMap.add(word, fullMeaning); // Adding the word and the meaning
    }

    private static void indexOutput(Map<String, String> glossary,
            SimpleWriter out, String fileName, Queue<String> words,
            String folderName) { // To output the index page html code to index.html file

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Glossary</title>");
        out.println("</head>");
        out.println("<h2>Glossary<h2>");
        out.println("<hr/>");
        out.println("<h3>Index</h3>");
        out.println("<body>");
        out.println("<ul>");

        Map<String, String> temp = glossary.newInstance();
        temp.transferFrom(glossary); // Temporary variable for looping

        while (temp.size() > 0) {

            Map.Pair<String, String> pair = temp.remove(words.dequeue()); // Taking out the pair in the map in alphabetical order using sorted keys in the queue

            String name = pair.key() + ".html";

            SimpleWriter fileOut = new SimpleWriter1L(folderName + name);

            processItem(pair, fileOut, fileName);

            out.println("<li><a href =\"" + name + "\">" + pair.key()
                    + "</a></li>");

            glossary.add(pair.key(), pair.value());

        }

        out.println("</ul>");
        out.println("</body>");
        out.println("</html>");
    }

    private static void processItem(Map.Pair<String, String> item,
            SimpleWriter out, String fileName) {

        out.println("<html>");
        out.println("<head>");
        out.println("<title>" + item.key() + "</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2><b><i><font color = 'red'>" + item.key()
                + "</font></i></b></h2>");
        out.println("<blockquote>" + item.value() + "</blockquote><hr/>");

        out.println("<p>Return to <a href = 'index.html'>index.</a></p>");
        out.println("</body>");
        out.println("</html>");

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

        out.println("Enter input file name:");
        String inputFile = in.nextLine(); //Input file name

        SimpleReader fileIn = new SimpleReader1L(inputFile);

        out.println("Enter the name of the output folder :");
        String outFolder = in.nextLine() + "/"; // Output folder name

        String mainFile = outFolder + "index.html"; // To place index.html in the user desired existing folder
        SimpleWriter fileOut = new SimpleWriter1L(mainFile);

        Map<String, String> glossary = new Map1L<String, String>();
        Queue<String> words = new Queue1L<>();

        Comparator<String> c = new StringLT();

        while (!fileIn.atEOS()) {

            getGlossaryMap(glossary, fileIn, words);
        }

        words.sort(c);

        indexOutput(glossary, fileOut, mainFile, words, outFolder);

        /*
         * Close input and output streams
         */
        fileIn.close();
        fileOut.close();

        in.close();
        out.close();
    }

}
